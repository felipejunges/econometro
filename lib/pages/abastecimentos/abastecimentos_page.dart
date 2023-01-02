import 'package:econometro/models/abastecimento.dart';
import 'package:econometro/pages/abastecimentos/abastecimento_form_page.dart';
import 'package:econometro/services/abastecimento_provider.dart';
import 'package:econometro/widgets/abastecimento_card.dart';
import 'package:econometro/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AbastecimentosPage extends StatelessWidget {
  const AbastecimentosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abastecimentos'),
      ),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AbastecimentoFormPage())),
      ),
      body: _page(context),
    );
  }

  Widget _page(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: _futureLista(context),
      ),
    );
  }

  FutureBuilder<void> _futureLista(context) {
    return FutureBuilder(
      future: Provider.of<AbastecimentoProvider>(context, listen: false).listAbastecimentos(),
      builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
          ? const Center(child: CircularProgressIndicator())
          : Consumer<AbastecimentoProvider>(
              child: const Center(child: Text('Nenhum abastecimento cadastrado :(')),
              builder: (context, value, child) => value.abastecimentos.isEmpty ? child! : _itens(value.abastecimentos),
            ),
    );
  }

  // FutureBuilder<void> _futureDropdown(context) {
  //   return FutureBuilder(
  //     future: Provider.of<VeiculoProvider>(context, listen: false).listVeiculos(),
  //     builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
  //         ? const Center(child: CircularProgressIndicator())
  //         : Consumer<VeiculoProvider>(
  //             builder: (context, value, child) => _listaVeiculos(value.veiculos, value.veiculoSelecionadoId, context),
  //           ),
  //   );
  // }

  // Widget _listaVeiculos(List<Veiculo> veiculos, int? veiculoSelecionadoId, context) {
  //   var itens = veiculos.map((v) => DropdownMenuItem<int>(value: v.id, child: Text(v.placa))).toList();

  //   return DropdownButton(
  //     items: itens,
  //     isExpanded: true,
  //     value: veiculoSelecionadoId,
  //     onChanged: (value) => {
  //       Provider.of<VeiculoProvider>(context, listen: false).changeVeiculoId(value!),
  //     },
  //   );
  // }

  Widget _itens(List<Abastecimento> abastecimentos) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GroupedListView<Abastecimento, String>(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        elements: abastecimentos,
        groupBy: (element) => DateFormat('MMM/yyyy').format(element.data),
        groupSeparatorBuilder: (String groupByValue) => Text(groupByValue, textAlign: TextAlign.center),
        itemBuilder: (context, Abastecimento element) => AbastecimentoCard(abastecimento: element),
        itemComparator: (item1, item2) => item1.data.compareTo(item2.data), // optional
        //useStickyGroupSeparators: true, // optional
        //floatingHeader: false, // optional
        order: GroupedListOrder.DESC,
      ),
    );
  }
}
