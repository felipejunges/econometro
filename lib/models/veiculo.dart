class Veiculo {
  final int? id;
  final String placa;
  final String marca;
  final String modelo;
  final int ano;

  Veiculo({
    this.id,
    required this.placa,
    required this.marca,
    required this.modelo,
    required this.ano,
  });

  static String tableName = "veiculos";
  static List<String> fieldNames = ['_id', 'placa', 'marca', 'modelo', 'ano'];

  Veiculo.fromMap(Map<String, dynamic> res)
      : id = res["_id"],
        placa = res["placa"],
        marca = res["marca"],
        modelo = res["modelo"],
        ano = res["ano"];

  Map<String, Object?> toMap() => {
        '_id': id,
        'placa': placa,
        'marca': marca,
        'modelo': modelo,
        'ano': ano,
      };

  Veiculo copy({
    int? id,
    String? placa,
    String? marca,
    String? modelo,
    int? ano,
  }) =>
      Veiculo(
        id: id ?? this.id,
        placa: placa ?? this.placa,
        marca: marca ?? this.marca,
        modelo: modelo ?? this.modelo,
        ano: ano ?? this.ano,
      );
}
