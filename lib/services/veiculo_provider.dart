import 'package:econometro/databases/veiculo_database.dart';
import 'package:econometro/models/veiculo.dart';
import 'package:flutter/material.dart';

class VeiculoProvider extends ChangeNotifier {
  VeiculoDatabase? _database;
  Future<VeiculoDatabase> get database => _initDatabase();

  List<Veiculo> _veiculos = [];
  List<Veiculo> get veiculos => List.from(_veiculos);

  Future<void> listVeiculos() async {
    var db = await database;

    _veiculos = await db.listVeiculos();

    notifyListeners();
  }

  Future<void> insert(Veiculo veiculo) async {
    var db = await database;

    await db.insert(veiculo);

    await listVeiculos();
  }

  Future<VeiculoDatabase> _initDatabase() async {
    if (_database != null) return _database!;

    _database = VeiculoDatabase.instance;
    return _database!;
  }

  @override
  void dispose() async {
    super.dispose();

    var db = await database;
    db.close();
  }
}
