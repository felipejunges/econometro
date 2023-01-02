import 'dart:async';

import 'package:econometro/databases/base_database.dart';
import 'package:econometro/models/veiculo.dart';

class VeiculoDatabase extends BaseDatabase {
  static final VeiculoDatabase instance = VeiculoDatabase._init();

  VeiculoDatabase._init();

  Future<Veiculo?> getVeiculo(int id) async {
    var db = await instance.database;

    List<Map<String, dynamic>> maps = await db.query(Veiculo.tableName, columns: Veiculo.fieldNames, where: '_id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Veiculo.fromMap(maps.first);
    }

    return null;
  }

  Future<List<Veiculo>> listAllVeiculos() async {
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
}
