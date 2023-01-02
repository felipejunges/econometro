import 'package:econometro/models/abastecimento.dart';
import 'package:path/path.dart' as p;

import 'package:econometro/models/veiculo.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseDatabase {
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('veiculos.db');
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, filepath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
        create table ${Veiculo.tableName} ( 
          _id integer primary key autoincrement NOT NULL, 
          placa TEXT NOT NULL,
          marca TEXT NOT NULL,
          modelo TEXT NOT NULL,
          ano INTEGER NOT NULL
        )''');

    await db.execute('''
        create table ${Abastecimento.tableName} ( 
          _id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
          veiculo_id INTEGER NOT NULL,
          data text NOT NULL,
          km integer NOT NULL,
          litros real NOT NULL,
          valor_litro real NULL,
          FOREIGN KEY (veiculo_id) REFERENCES ${Veiculo.tableName} (_id)
        )''');
  }

  Future close() async {
    var db = await database;
    db.close();
  }
}
