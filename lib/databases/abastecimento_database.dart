import 'package:econometro/databases/base_database.dart';
import 'package:econometro/models/abastecimento.dart';

class AbastecimentoDatabase extends BaseDatabase {
  static final AbastecimentoDatabase instance = AbastecimentoDatabase._init();

  AbastecimentoDatabase._init();

  Future<Abastecimento?> getAbastecimento(int id) async {
    var db = await instance.database;

    List<Map<String, dynamic>> maps = await db.query(Abastecimento.tableName, columns: Abastecimento.fieldNames, where: '_id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Abastecimento.fromMap(maps.first);
    }

    return null;
  }

  Future<List<Abastecimento>> listAllAbastecimentos() async {
    var db = await instance.database;

    List<Map<String, dynamic>> maps = await db.query(Abastecimento.tableName, columns: Abastecimento.fieldNames, orderBy: '_id');

    if (maps.isNotEmpty) {
      return maps.map((e) => Abastecimento.fromMap(e)).toList();
    }

    return [];
  }

  Future<Abastecimento> insert(Abastecimento abastecimento) async {
    var db = await instance.database;

    var id = await db.insert(Abastecimento.tableName, abastecimento.toMap());

    return abastecimento.copy(id: id);
  }

  Future<int> update(Abastecimento abastecimento) async {
    var db = await instance.database;

    return await db.update(Abastecimento.tableName, abastecimento.toMap(), where: '_id = ?', whereArgs: [abastecimento.id]);
  }

  Future<int> delete(int id) async {
    var db = await instance.database;

    return await db.delete(Abastecimento.tableName, where: '_id = ?', whereArgs: [id]);
  }

  Future close() async {
    var db = await instance.database;

    db.close();
  }
}
