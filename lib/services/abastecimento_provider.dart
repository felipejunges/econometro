import 'package:econometro/databases/abastecimento_database.dart';
import 'package:econometro/models/abastecimento.dart';
import 'package:flutter/material.dart';

class AbastecimentoProvider extends ChangeNotifier {
  AbastecimentoDatabase? _database;
  Future<AbastecimentoDatabase> get database => _initDatabase();

  List<Abastecimento> _abastecimentos = [];
  List<Abastecimento> get abastecimentos => List.from(_abastecimentos);

  Future<void> listVeiculos() async {
    var db = await database;

    _abastecimentos = await db.listAllAbastecimentos();

    notifyListeners();
  }

  Future<void> save(Abastecimento abastecimento) async {
    if (abastecimento.id == null) {
      return insert(abastecimento);
    } else {
      return update(abastecimento);
    }
  }

  Future<void> insert(Abastecimento abastecimento) async {
    var db = await database;

    await db.insert(abastecimento);

    await listVeiculos();
  }

  Future<void> update(Abastecimento abastecimento) async {
    var db = await database;

    await db.update(abastecimento);

    await listVeiculos();
  }

  Future<AbastecimentoDatabase> _initDatabase() async {
    if (_database != null) return _database!;

    _database = AbastecimentoDatabase.instance;
    return _database!;
  }

  @override
  void dispose() async {
    super.dispose();

    var db = await database;
    db.close();
  }
}
