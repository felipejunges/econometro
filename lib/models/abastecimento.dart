import 'package:intl/intl.dart';

class Abastecimento {
  final int? id;
  final DateTime data;
  final int km;
  final double litros;
  final double? valorLitro;

  Abastecimento({
    this.id,
    required this.data,
    required this.km,
    required this.litros,
    this.valorLitro,
  });

  static String tableName = "abastecimentos";
  static List<String> fieldNames = ['_id', 'data', 'km', 'litros', 'valor_litro'];

  // combustivel
  // posto
  // obs

  Abastecimento.fromMap(Map<String, dynamic> res)
      : id = res["_id"],
        data = DateFormat('yyyy-MM-dd').parse(res['data']),
        km = res["km"],
        litros = res["litros"],
        valorLitro = res["valor_litro"];

  Map<String, Object?> toMap() => {
        '_id': id,
        'data': DateFormat('yyyy-MM-dd').format(data),
        'km': km,
        'litros': litros,
        'valor_litro': valorLitro,
      };

  Abastecimento copy({
    int? id,
    DateTime? data,
    int? km,
    double? litros,
    double? valorLitro,
  }) =>
      Abastecimento(
        id: id ?? this.id,
        data: data ?? this.data,
        km: km ?? this.km,
        litros: litros ?? this.litros,
        valorLitro: valorLitro ?? this.valorLitro,
      );
}
