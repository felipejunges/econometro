import 'package:econometro/models/veiculo.dart';
import 'package:econometro/pages/veiculos/veiculo_form_page.dart';
import 'package:flutter/material.dart';

enum AcaoCard { editar, excluir }

class VeiculoCard extends StatelessWidget {
  const VeiculoCard({required this.veiculo, super.key});

  final Veiculo veiculo;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Column(children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          child: Image.network(
            'https://http2.mlstatic.com/D_NQ_NP_669071-MLB50301908228_062022-O.jpg',
            fit: BoxFit.cover,
          ),
        ),
        ListTile(
          onLongPress: () => Navigator.push(context, MaterialPageRoute(builder: (context) => VeiculoFormPage())),
          title: const Text("Honda Civic 2011"),
          subtitle: const Text("85.000 KM"),
          leading: const CircleAvatar(
            child: Icon(Icons.car_repair),
          ),
          trailing: _teste(),
        ),
      ]),
    );
  }

  Widget _teste() {
    return PopupMenuButton<AcaoCard>(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (context) {
        return const [
          PopupMenuItem(
            value: AcaoCard.editar,
            child: Text('Editar'),
          ),
          PopupMenuItem(
            value: AcaoCard.excluir,
            child: Text('Excluir'),
          )
        ];
      },
      onSelected: (value) {
        if (value == AcaoCard.editar) {
        } else if (value == AcaoCard.excluir) {}
      },
    );
  }
}
