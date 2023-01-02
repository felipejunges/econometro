import 'package:econometro/databases/veiculo_database.dart';
import 'package:econometro/models/veiculo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VeiculoProvider extends ChangeNotifier {
  VeiculoDatabase? _database;
  Future<VeiculoDatabase> get database => _initDatabase();

  List<Veiculo> _veiculos = [];
  List<Veiculo> get veiculos => List.from(_veiculos);

  final String SHARED_KEY = 'veiculo_selecionado_id_key';

  int? veiculoSelecionadoId = 1;

  VeiculoProvider() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.containsKey(SHARED_KEY)) {
        var value = prefs.getInt(SHARED_KEY);

        veiculoSelecionadoId = value;
        //     notifyListeners();
      }
    });
  }

  Future<void> listVeiculos() async {
    var db = await database;

    _veiculos = await db.listAllVeiculos();

    notifyListeners();
  }

  Future<void> save(Veiculo veiculo) async {
    if (veiculo.id == null) {
      return insert(veiculo);
    } else {
      return update(veiculo);
    }
  }

  Future<void> insert(Veiculo veiculo) async {
    var db = await database;

    await db.insert(veiculo);

    await listVeiculos();
  }

  Future<void> update(Veiculo veiculo) async {
    var db = await database;

    await db.update(veiculo);

    await listVeiculos();
  }

  Future<VeiculoDatabase> _initDatabase() async {
    if (_database != null) return _database!;

    _database = VeiculoDatabase.instance;
    return _database!;
  }

  changeVeiculoId(int value) {
    veiculoSelecionadoId = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt(SHARED_KEY, value);
      notifyListeners();
    });
  }

  // @override
  // void dispose() async {
  //   super.dispose();

  //   // TODO: resovler este problema
  //   //var db = await database;
  //   //db.close();
  // }
}
