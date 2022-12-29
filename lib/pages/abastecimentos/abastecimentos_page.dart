import 'package:econometro/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class AbastecimentosPage extends StatelessWidget {
  const AbastecimentosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Abastecimentos')),
      drawer: const AppDrawer(),
      body: const Text('oi'),
    );
  }
}
