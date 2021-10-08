import 'package:sqflite/sqflite.dart' as sql;

class MensajerosCRUD {
//Crear Tablas
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE mensajeros(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nombre TEXT,
        foto TEXT,
        placa TEXT,
        telefono TEXT,
        whatsapp TEXT,
        moto TEXT,
        soat TEXT,
        tecno TEXT,
        activo TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'mensajeros.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Guardar Mensajero
  static Future<int> guardarMensajero(nombre, foto, placa, telefono, whatsapp,
      moto, soat, tecno, activo) async {
    final db = await MensajerosCRUD.db();

    final data = {
      'nombre': nombre,
      'foto': foto,
      'placa': placa,
      'telefono': telefono,
      'whatsapp': whatsapp,
      'moto': moto,
      'soat': soat,
      'tecno': tecno,
      'activo': activo
    };
    final id = await db.insert('mensajeros', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

//Listar Mensajeros
  static Future<List<Map<String, dynamic>>> listarMensajeros() async {
    final db = await MensajerosCRUD.db();
    return db.query('mensajeros', orderBy: "id");
  }

  //Obtener Por ID
  static Future<List<Map<String, dynamic>>> obtenerMensajero(int id) async {
    final db = await MensajerosCRUD.db();
    return db.query('mensajeros', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Actualizar por ID
  static Future<int> actualizarMensajero(id, nombre, foto, placa, telefono,
      whatsapp, moto, soat, tecno, activo) async {
    final db = await MensajerosCRUD.db();

    final data = {
      'nombre': nombre,
      'foto': foto,
      'placa': placa,
      'telefono': telefono,
      'whatsapp': whatsapp,
      'moto': moto,
      'soat': soat,
      'tecno': tecno,
      'activo': activo,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('mensajeros', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Eliminar
  static Future<void> eliminarMensajero(int id) async {
    final db = await MensajerosCRUD.db();
    try {
      await db.delete("mensajeros", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print("Error: $err");
    }
  }
}
