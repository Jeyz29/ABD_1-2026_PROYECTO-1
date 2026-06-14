import sys
import tkinter as tk
from tkinter import ttk, messagebox, simpledialog
import pypyodbc as pyodbc

# ==============================================================================
# CONFIGURACIÓN DE CONEXIÓN A LA BASE DE DATOS
# ==============================================================================
SERVER = "localhost"                     # Servidor o instancia de SQL Server
DATABASE = "StreamUCV"                   # Nombre de la base de datos
USERNAME = "sa"                            # Usuario (ej. "sa")
PASSWORD = "tu_password"                            # Contraseña
DRIVER = "ODBC Driver 17 for SQL Server" # Driver de conexión ODBC
# ==============================================================================


class DatabaseHandler:
    def __init__(self):
        try:
            if not USERNAME or USERNAME == "":
                conn_str = f"DRIVER={{{DRIVER}}};SERVER={SERVER};DATABASE={DATABASE};Trusted_Connection=yes;"
            else:
                conn_str = f"DRIVER={{{DRIVER}}};SERVER={SERVER};DATABASE={DATABASE};UID={USERNAME};PWD={PASSWORD}"
            self.conn = pyodbc.connect(conn_str)
            self.cursor = self.conn.cursor()
        except pyodbc.Error as e:
            print(f"Error al conectar a la base de datos: {e}")
            raise

    def get_tables_and_indexes(self):
        query_tables = "SELECT t.name FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id WHERE s.name = 'streaming';"
        self.cursor.execute(query_tables)
        tables = [row[0] for row in self.cursor.fetchall()]

        query_indexes = """
        SELECT t.name, i.name 
        FROM sys.indexes i 
        JOIN sys.tables t ON i.object_id = t.object_id 
        JOIN sys.schemas s ON t.schema_id = s.schema_id 
        WHERE s.name = 'streaming' AND i.type > 0;
        """
        self.cursor.execute(query_indexes)
        indexes = self.cursor.fetchall()
        
        return tables, indexes

    def get_tables_and_indexes_counts(self):
        tables, indexes = self.get_tables_and_indexes()
        total_tables = len(tables)
        indexes_per_table = {t: 0 for t in tables}
        for t_name, i_name in indexes:
            indexes_per_table[t_name] += 1
        return total_tables, indexes_per_table

    def get_constraints(self):
        query = """
        SELECT c.name as constraint_name, t.name as table_name, c.type_desc as constraint_type 
        FROM sys.objects c 
        JOIN sys.tables t ON c.parent_object_id = t.object_id 
        JOIN sys.schemas s ON t.schema_id = s.schema_id 
        WHERE s.name = 'streaming' AND c.type IN ('C', 'D', 'F', 'PK', 'UQ');
        """
        self.cursor.execute(query)
        return self.cursor.fetchall()

    def get_indexes_details(self):
        query = """
        SELECT i.name as index_name, t.name as table_name, c.name as column_name, 
               i.is_unique, i.type_desc as index_type 
        FROM sys.indexes i 
        JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id 
        JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id 
        JOIN sys.tables t ON i.object_id = t.object_id 
        JOIN sys.schemas s ON t.schema_id = s.schema_id 
        WHERE s.name = 'streaming' AND i.type > 0 
        ORDER BY t.name, i.name, ic.key_ordinal;
        """
        self.cursor.execute(query)
        return self.cursor.fetchall()

    def get_triggers(self):
        query = """
        SELECT tr.name as trigger_name, tr.type_desc as type, 
               CASE WHEN tr.is_disabled = 0 THEN 'Activo' ELSE 'Inactivo' END as estado, 
               t.name as table_name 
        FROM sys.triggers tr 
        JOIN sys.tables t ON tr.parent_id = t.object_id 
        JOIN sys.schemas s ON t.schema_id = s.schema_id 
        WHERE s.name = 'streaming';
        """
        self.cursor.execute(query)
        return self.cursor.fetchall()

    def get_tables_size(self):
        query = """
        SELECT t.name AS table_name, SUM(p.used_page_count) * 8.0 AS size_kb 
        FROM sys.tables t 
        JOIN sys.schemas s ON t.schema_id = s.schema_id 
        JOIN sys.dm_db_partition_stats p ON t.object_id = p.object_id 
        WHERE s.name = 'streaming' 
        GROUP BY t.name;
        """
        self.cursor.execute(query)
        return self.cursor.fetchall()

    def get_columns_size(self):
        query = """
        SELECT t.name as table_name, c.name as column_name, ty.name as data_type, 
               c.max_length as max_length_bytes 
        FROM sys.columns c 
        JOIN sys.tables t ON c.object_id = t.object_id 
        JOIN sys.schemas s ON t.schema_id = s.schema_id 
        JOIN sys.types ty ON c.user_type_id = ty.user_type_id 
        WHERE s.name = 'streaming' 
        ORDER BY t.name, c.column_id;
        """
        self.cursor.execute(query)
        return self.cursor.fetchall()

    def get_record_sizes(self):
        columns = self.get_columns_size()
        record_sizes = {}
        for row in columns:
            table_name = row[0]
            max_length_bytes = row[3]
            if table_name not in record_sizes:
                record_sizes[table_name] = 0
            record_sizes[table_name] += max_length_bytes
        return record_sizes

    def get_blocking_factors(self):
        record_sizes = self.get_record_sizes()
        blocking_factors = {}
        PAGE_SIZE = 8192
        for table, size in record_sizes.items():
            if size > 0:
                blocking_factors[table] = PAGE_SIZE // size
            else:
                blocking_factors[table] = 0
        return blocking_factors

    def estimate_query_cost(self, table_name, column_name):
        query_index = """
        SELECT i.name, i.is_unique
        FROM sys.indexes i 
        JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id 
        JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id 
        JOIN sys.tables t ON i.object_id = t.object_id 
        JOIN sys.schemas s ON t.schema_id = s.schema_id 
        WHERE s.name = 'streaming' AND t.name = ? AND c.name = ? AND ic.key_ordinal = 1
        """
        self.cursor.execute(query_index, (table_name, column_name))
        index_row = self.cursor.fetchone()

        query_pages = """
        SELECT SUM(p.used_page_count) 
        FROM sys.tables t 
        JOIN sys.schemas s ON t.schema_id = s.schema_id 
        JOIN sys.dm_db_partition_stats p ON t.object_id = p.object_id 
        WHERE s.name = 'streaming' AND t.name = ? AND p.index_id IN (0, 1)
        """
        self.cursor.execute(query_pages, (table_name,))
        pages_row = self.cursor.fetchone()
        table_pages = pages_row[0] if pages_row and pages_row[0] else 0

        TRANSFER_SPEED_MB_S = 17
        TRANSFER_SPEED_BYTES_S = TRANSFER_SPEED_MB_S * 1024 * 1024
        PAGE_SIZE_BYTES = 8192
        
        cost_accesses = 0
        used_index = False
        index_name = ""

        if index_row:
            used_index = True
            index_name = index_row[0]
            # Estimación: Asumimos que la raíz del índice B-Tree está en caché de memoria, 
            # por lo que el costo se reduce a leer solo 1 página de datos (1 acceso).
            cost_accesses = 1
        else:
            used_index = False
            cost_accesses = table_pages

        total_bytes_read = cost_accesses * PAGE_SIZE_BYTES
        time_seconds = total_bytes_read / TRANSFER_SPEED_BYTES_S if TRANSFER_SPEED_BYTES_S > 0 else 0

        return {
            "table": table_name,
            "column": column_name,
            "used_index": used_index,
            "index_name": index_name,
            "accesses": cost_accesses,
            "time_ms": time_seconds * 1000
        }

    def close(self):
        self.conn.close()


class AppGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("StreamUCV - Administrador de Diccionario de Datos")
        self.root.geometry("900x600")
        
        try:
            self.db = DatabaseHandler()
        except Exception as e:
            messagebox.showerror("Error de Conexión", f"No se pudo conectar a la base de datos.\nVerifica los datos al inicio del programa.\nError: {e}")
            self.root.destroy()
            return
            
        self.create_widgets()

    def create_widgets(self):
        btn_frame = tk.Frame(self.root, padx=10, pady=10)
        btn_frame.pack(side=tk.TOP, fill=tk.X)
        
        botones = [
            ("1. Listar Tablas e Índices", self.req1_listar),
            ("2. Cantidad de Tablas e Índices", self.req2_cantidad),
            ("3. Restricciones", self.req3_restricciones),
            ("4. Detalle de Índices", self.req4_indices),
            ("5. Triggers", self.req5_triggers),
            ("6. Tamaño de Tablas", self.req6_tamano_tablas),
            ("7. Tamaño de Registro", self.req7_tamano_registro),
            ("8. Tamaño de Columnas", self.req8_tamano_columnas),
            ("9. Factor de Bloqueo", self.req9_factor_bloqueo),
            ("10. Costo de Consulta", self.req10_costo_consulta)
        ]
        
        for i, (text, command) in enumerate(botones):
            btn = tk.Button(btn_frame, text=text, command=command, width=25)
            btn.grid(row=i//5, column=i%5, padx=5, pady=5)
            
        self.lbl_resultado = tk.Label(self.root, text="Resultados:", font=("Arial", 12, "bold"))
        self.lbl_resultado.pack(anchor=tk.W, padx=10)
        
        tree_frame = tk.Frame(self.root, padx=10, pady=10)
        tree_frame.pack(side=tk.BOTTOM, fill=tk.BOTH, expand=True)
        
        scroll_y = ttk.Scrollbar(tree_frame, orient=tk.VERTICAL)
        scroll_y.pack(side=tk.RIGHT, fill=tk.Y)
        scroll_x = ttk.Scrollbar(tree_frame, orient=tk.HORIZONTAL)
        scroll_x.pack(side=tk.BOTTOM, fill=tk.X)
        
        self.tree = ttk.Treeview(tree_frame, yscrollcommand=scroll_y.set, xscrollcommand=scroll_x.set)
        self.tree.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        
        scroll_y.config(command=self.tree.yview)
        scroll_x.config(command=self.tree.xview)
        
        self.text_info = tk.Text(tree_frame, height=5, state=tk.DISABLED)
        self.text_info.pack_forget()

    def clear_results(self, show_tree=True):
        for item in self.tree.get_children():
            self.tree.delete(item)
            
        if show_tree:
            self.text_info.pack_forget()
            self.tree.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        else:
            self.tree.pack_forget()
            self.text_info.pack(side=tk.BOTTOM, fill=tk.X)
            self.text_info.config(state=tk.NORMAL)
            self.text_info.delete(1.0, tk.END)

    def set_tree_columns(self, columns):
        self.tree["columns"] = columns
        self.tree["show"] = "headings"
        for col in columns:
            self.tree.heading(col, text=col)
            self.tree.column(col, anchor=tk.W)

    def req1_listar(self):
        self.clear_results()
        try:
            tables, indexes = self.db.get_tables_and_indexes()
            self.set_tree_columns(("Tipo", "Nombre de Objeto", "Tabla Asociada"))
            
            for t in tables:
                self.tree.insert("", tk.END, values=("Tabla", t, "-"))
            for t_name, i_name in indexes:
                self.tree.insert("", tk.END, values=("Índice", i_name, t_name))
        except Exception as e:
            messagebox.showerror("Error", str(e))

    def req2_cantidad(self):
        self.clear_results()
        try:
            total, per_table = self.db.get_tables_and_indexes_counts()
            self.set_tree_columns(("Tabla", "Cantidad de Índices"))
            
            self.tree.insert("", tk.END, values=(f"TOTAL DE TABLAS: {total}", ""))
            self.tree.insert("", tk.END, values=("-"*20, "-"*20))
            
            for t, count in per_table.items():
                self.tree.insert("", tk.END, values=(t, count))
        except Exception as e:
            messagebox.showerror("Error", str(e))

    def req3_restricciones(self):
        self.clear_results()
        try:
            data = self.db.get_constraints()
            self.set_tree_columns(("Nombre Restricción", "Tabla Asociada", "Tipo de Restricción"))
            for row in data:
                self.tree.insert("", tk.END, values=row)
        except Exception as e:
            messagebox.showerror("Error", str(e))

    def req4_indices(self):
        self.clear_results()
        try:
            data = self.db.get_indexes_details()
            self.set_tree_columns(("Índice", "Tabla", "Columna", "Único", "Tipo de Índice"))
            for row in data:
                is_unique = "Sí" if row[3] else "No"
                self.tree.insert("", tk.END, values=(row[0], row[1], row[2], is_unique, row[4]))
        except Exception as e:
            messagebox.showerror("Error", str(e))

    def req5_triggers(self):
        self.clear_results()
        try:
            data = self.db.get_triggers()
            if not data:
                messagebox.showinfo("Triggers", "No se encontraron triggers en el esquema 'streaming'.")
                return
            self.set_tree_columns(("Trigger", "Tipo", "Estado", "Tabla Activa"))
            for row in data:
                self.tree.insert("", tk.END, values=row)
        except Exception as e:
            messagebox.showerror("Error", str(e))

    def req6_tamano_tablas(self):
        self.clear_results()
        try:
            data = self.db.get_tables_size()
            self.set_tree_columns(("Tabla", "Tamaño (KB)"))
            for row in data:
                self.tree.insert("", tk.END, values=(row[0], f"{row[1]:.2f}"))
        except Exception as e:
            messagebox.showerror("Error", str(e))

    def req7_tamano_registro(self):
        self.clear_results()
        try:
            data = self.db.get_record_sizes()
            self.set_tree_columns(("Tabla", "Tamaño Estimado de Registro (Bytes)"))
            for t_name, size in data.items():
                self.tree.insert("", tk.END, values=(t_name, size))
        except Exception as e:
            messagebox.showerror("Error", str(e))

    def req8_tamano_columnas(self):
        self.clear_results()
        try:
            data = self.db.get_columns_size()
            self.set_tree_columns(("Tabla", "Columna", "Tipo de Dato", "Tamaño Máximo (Bytes)"))
            for row in data:
                self.tree.insert("", tk.END, values=row)
        except Exception as e:
            messagebox.showerror("Error", str(e))

    def req9_factor_bloqueo(self):
        self.clear_results()
        try:
            data = self.db.get_blocking_factors()
            self.set_tree_columns(("Tabla", "Factor de Bloqueo (Registros/Página de 8KB)"))
            for t_name, fb in data.items():
                self.tree.insert("", tk.END, values=(t_name, fb))
        except Exception as e:
            messagebox.showerror("Error", str(e))

    def req10_costo_consulta(self):
        table_name = simpledialog.askstring("Entrada", "Ingrese el nombre de la tabla:", parent=self.root)
        if not table_name: return
        column_name = simpledialog.askstring("Entrada", "Ingrese el nombre de la columna para la igualdad:", parent=self.root)
        if not column_name: return
        
        self.clear_results(show_tree=False)
        try:
            res = self.db.estimate_query_cost(table_name, column_name)
            
            info = f"Análisis para: SELECT * FROM {table_name} WHERE {column_name} = 'valor'\n\n"
            if res['used_index']:
                info += f"Se puede usar el índice: {res['index_name']}\n"
            else:
                info += f"No hay índice aplicable. Se realizará un Full Table Scan.\n"
                
            info += f"Cantidad estimada de accesos a disco (Bloques de 8KB): {res['accesses']}\n"
            info += f"Tiempo estimado (Transferencia de 17MB/s): {res['time_ms']:.4f} milisegundos\n"
            
            self.text_info.insert(tk.END, info)
            self.text_info.config(state=tk.DISABLED)
            
        except Exception as e:
            messagebox.showerror("Error", f"Error al estimar costo: {e}")

    def on_closing(self):
        if hasattr(self, 'db'):
            self.db.close()
        self.root.destroy()

def main():
    root = tk.Tk()
    app = AppGUI(root)
    root.protocol("WM_DELETE_WINDOW", app.on_closing)
    root.mainloop()

if __name__ == "__main__":
    main()
