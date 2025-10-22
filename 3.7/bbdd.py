# ==========================================
# sp_menu_comentado.py
# CRUD básico con Procedimientos Almacenados (MySQL) desde Python
# Autor: Dany
# Propósito: Permitir insertar, listar, eliminar lógicamente y restaurar empleados
# utilizando procedimientos almacenados y el conector oficial de MySQL.
# ==========================================

import mysql.connector

# ---------- CONFIGURACIÓN DE CONEXIÓN ----------
DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "1234",  # Reemplaza con tu contraseña real
    "database": "empresa"
}

# ---------- FUNCIÓN DE CONEXIÓN ----------
def conectar():
    """
    Crea y devuelve una conexión a MySQL usando los parámetros definidos en DB_CONFIG.
    """
    return mysql.connector.connect(**DB_CONFIG)

# ---------- FUNCIONES PRINCIPALES ----------
def sp_insertar(nombre: str, cargo: str, sueldo: float) -> int:
    """
    Inserta un nuevo empleado usando el procedimiento almacenado:
    sp_insertar_empleado(IN p_nombre, IN p_cargo, IN p_sueldo, OUT p_nuevo_id)
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        args = [nombre, cargo, sueldo, 0]
        args = cur.callproc("sp_insertar_empleado", args)
        cnx.commit()
        nuevo_id = args[3]
        print(f"✅ Insertado correctamente. Nuevo ID: {nuevo_id}")
        return nuevo_id
    except mysql.connector.Error as e:
        print("❌ Error en sp_insertar:", e)
        if cnx and cnx.is_connected():
            try:
                cnx.rollback()
            except:
                pass
        return -1
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

def sp_listar_activos():
    """
    Llama al procedimiento almacenado sp_listar_empleados_activos().
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("sp_listar_empleados_activos")
        print("=== EMPLEADOS ACTIVOS ===")
        for result in cur.stored_results():
            for (id_, nombre, cargo, sueldo, created_at, updated_at) in result.fetchall():
                ua = updated_at if updated_at else "-"
                print(f"ID:{id_:<3} | Nombre:{nombre:<15} | Cargo:{cargo:<13} | "
                      f"Sueldo:${sueldo:,.0f} | Creado:{created_at} | Actualizado:{ua}")
    except mysql.connector.Error as e:
        print("❌ Error en sp_listar_activos:", e)
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

def sp_listar_todos():
    """
    Llama al procedimiento almacenado sp_listar_empleados_todos().
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("sp_listar_empleados_todos")
        print("=== EMPLEADOS (TODOS) ===")
        for result in cur.stored_results():
            for (id_, nombre, cargo, sueldo, eliminado, created_at, updated_at, deleted_at) in result.fetchall():
                estado = "ACTIVO" if eliminado == 0 else "ELIMINADO"
                ua = updated_at if updated_at else "-"
                da = deleted_at if deleted_at else "-"
                print(f"ID:{id_:<3} | Nombre:{nombre:<15} | Cargo:{cargo:<13} | "
                      f"Sueldo:${sueldo:,.0f} | {estado:<9} | Creado:{created_at} | "
                      f"Actualizado:{ua} | Eliminado:{da}")
    except mysql.connector.Error as e:
        print("❌ Error en sp_listar_todos:", e)
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

def sp_borrado_logico(id_empleado: int):
    """
    Aplica borrado lógico (no físico) de un empleado mediante el procedimiento:
    sp_borrado_logico_empleado(IN p_id)
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("sp_borrado_logico_empleado", [id_empleado])
        cnx.commit()
        print(f"✅ Borrado lógico aplicado al ID {id_empleado} (si estaba activo).")
    except mysql.connector.Error as e:
        print("❌ Error en sp_borrado_logico:", e)
        if cnx and cnx.is_connected():
            try:
                cnx.rollback()
            except:
                pass
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

def sp_restaurar(id_empleado: int):
    """
    Restaura un empleado eliminado lógicamente mediante:
    sp_restaurar_empleado(IN p_id)
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("sp_restaurar_empleado", [id_empleado])
        cnx.commit()
        print(f"✅ Restaurado ID {id_empleado} (si estaba eliminado).")
    except mysql.connector.Error as e:
        print("❌ Error en sp_restaurar:", e)
        if cnx and cnx.is_connected():
            try:
                cnx.rollback()
            except:
                pass
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

# ---------------- MENÚ PRINCIPAL ----------------
def menu():
    """
    Muestra un menú interactivo para ejecutar operaciones CRUD sobre empleados.
    """
    while True:
        print("\n===== MENÚ EMPLEADOS (MySQL + SP) =====")
        print("1) Insertar empleado")
        print("2) Listar empleados ACTIVOS")
        print("3) Listar empleados (TODOS)")
        print("4) Borrado lógico por ID")
        print("5) Restaurar por ID")
        print("0) Salir")

        opcion = input("Selecciona una opción: ").strip()

        if opcion == "1":
            nombre = input("Nombre: ").strip()
            cargo = input("Cargo: ").strip()
            try:
                sueldo = float(input("Sueldo (ej: 750000): ").strip())
            except ValueError:
                print("❌ Sueldo inválido.")
                continue
            sp_insertar(nombre, cargo, sueldo)

        elif opcion == "2":
            sp_listar_activos()

        elif opcion == "3":
            sp_listar_todos()

        elif opcion == "4":
            try:
                id_emp = int(input("ID a eliminar lógicamente: ").strip())
            except ValueError:
                print("❌ ID inválido.")
                continue
            sp_borrado_logico(id_emp)

        elif opcion == "5":
            try:
                id_emp = int(input("ID a restaurar: ").strip())
            except ValueError:
                print("❌ ID inválido.")
                continue
            sp_restaurar(id_emp)

        elif opcion == "0":
            print("👋 Saliendo del sistema...")
            break

        else:
            print("❌ Opción no válida. Intenta nuevamente.")

# Punto de entrada del programa
if __name__ == "__main__":
    menu()
