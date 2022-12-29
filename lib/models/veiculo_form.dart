import 'package:econometro/models/veiculo.dart';

class VeiculoForm {
  int? id;
  String? placa;
  String? marca;
  String? modelo;
  int? ano;

  Veiculo toVeiculo() {
    return Veiculo(
      id: id,
      placa: placa ?? '',
      marca: marca ?? '',
      modelo: modelo ?? '',
      ano: ano ?? 0,
    );
  }
}
