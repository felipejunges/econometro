import 'package:econometro/models/veiculo.dart';
import 'package:econometro/pages/veiculos/veiculo_form_page.dart';
import 'package:econometro/services/veiculo_provider.dart';
import 'package:econometro/widgets/app_drawer.dart';
import 'package:econometro/widgets/veiculo_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VeiculosPage extends StatelessWidget {
  const VeiculosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Veículos')),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const VeiculoFormPage())),
      ),
      body: _page(context),
    );
  }

  Widget _page(context) {
    return FutureBuilder(
      future: Provider.of<VeiculoProvider>(context, listen: false).listVeiculos(),
      builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
          ? const Center(child: CircularProgressIndicator())
          : Consumer<VeiculoProvider>(
              child: const Center(child: Text('Nenhum veículo cadastrado :(')),
              builder: (context, value, child) => value.veiculos.isEmpty ? child! : _itens(value.veiculos),
            ),
    );
  }

  Widget _itens(List<Veiculo> itens) {
    return ListView.builder(
      itemCount: itens.length,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () => {},
        child: VeiculoCard(veiculo: itens[index]),
      ),
    );
  }
}
