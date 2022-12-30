import 'package:econometro/models/abastecimento.dart';
import 'package:econometro/pages/abastecimentos/abastecimento_form_page.dart';
import 'package:flutter/material.dart';

enum AcaoCard { editar, excluir }

class AbastecimentoCard extends StatelessWidget {
  const AbastecimentoCard({required this.abastecimento, super.key});

  final Abastecimento abastecimento;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2,
      margin: const EdgeInsets.only(top: 4, bottom: 4),
      child: ListTile(
        onLongPress: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AbastecimentoFormPage(
              abastecimento: abastecimento,
            ),
          ),
        ),
        title: Text("${abastecimento.km} km"),
        subtitle: Text("${abastecimento.litros} L"),
        leading: const CircleAvatar(
          child: Icon(Icons.directions_car),
        ),
        trailing: _teste(),
      ),
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
