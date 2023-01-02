import 'package:econometro/databases/abastecimento_database.dart';
import 'package:econometro/models/abastecimento.dart';
import 'package:flutter/material.dart';

class AbastecimentoProvider extends ChangeNotifier {
  AbastecimentoDatabase? _database;
  Future<AbastecimentoDatabase> get database => _initDatabase();

  List<Abastecimento> abastecimentos = [];

  int? veiculoSelecionadoId;

  AbastecimentoProvider({required this.abastecimentos, this.veiculoSelecionadoId});

  Future<void> listAbastecimentos() async {
    var db = await database;

    abastecimentos = await db.listAllAbastecimentos(veiculoSelecionadoId ?? 0);

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

    await listAbastecimentos();
  }

  Future<void> update(Abastecimento abastecimento) async {
    var db = await database;

    await db.update(abastecimento);

    await listAbastecimentos();
  }

  Future<AbastecimentoDatabase> _initDatabase() async {
    if (_database != null) return _database!;

    _database = AbastecimentoDatabase.instance;
    return _database!;
  }

  // @override
  // void dispose() async {
  //   super.dispose();

  //   // TODO: resolver este problema
  //   //var db = await database;
  //   //db.close();
  // }
}
