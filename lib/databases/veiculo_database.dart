import 'dart:async';

import 'package:econometro/models/veiculo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class VeiculoDatabase {
  static final VeiculoDatabase instance = VeiculoDatabase._init();

  static Database? _database;

  VeiculoDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('veiculos2.db');
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
          placa text not null,
          marca text not null,
          modelo text not null,
          ano integer not null)
        ''');
  }

  Future<Veiculo?> getVeiculo(int id) async {
    var db = await instance.database;

    List<Map<String, dynamic>> maps = await db.query(Veiculo.tableName, columns: Veiculo.fieldNames, where: '_id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Veiculo.fromMap(maps.first);
    }

    return null;
  }

  Future<List<Veiculo>> listVeiculos() async {
    var db = await instance.database;

    List<Map<String, dynamic>> maps = await db.query(Veiculo.tableName, columns: Veiculo.fieldNames, orderBy: '_id');

    if (maps.isNotEmpty) {
      return maps.map((e) => Veiculo.fromMap(e)).toList();
    }

    return [];
  }

  Future<Veiculo> insert(Veiculo veiculo) async {
    var db = await instance.database;

    var id = await db.insert(Veiculo.tableName, veiculo.toMap());

    return veiculo.copy(id: id);
  }

  Future<int> update(Veiculo veiculo) async {
    var db = await instance.database;

    return await db.update(Veiculo.tableName, veiculo.toMap(), where: '_id = ?', whereArgs: [veiculo.id]);
  }

  Future<int> delete(int id) async {
    var db = await instance.database;

    return await db.delete(Veiculo.tableName, where: '_id = ?', whereArgs: [id]);
  }

  Future close() async {
    var db = await instance.database;

    db.close();
  }
}
