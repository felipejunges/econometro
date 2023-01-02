import 'package:econometro/models/abastecimento.dart';

class AbastecimentoForm {
  int? id;
  DateTime? data;
  int? km;
  double? litros;
  double? valorLitro;
  int? veiculoId;

  Abastecimento toAbastecimento() {
    return Abastecimento(
      id: id,
      data: data ?? DateTime.now(),
      km: km ?? 0,
      litros: litros ?? 0,
      valorLitro: valorLitro,
      veiculoId: veiculoId ?? 0,
    );
  }
}
