import 'package:econometro/pages/home_page.dart';
import 'package:econometro/services/abastecimento_provider.dart';
import 'package:econometro/services/veiculo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<VeiculoProvider>(create: (_) => VeiculoProvider()),
        ChangeNotifierProvider<AbastecimentoProvider>(create: (_) => AbastecimentoProvider()),
      ],
      child: MaterialApp(
        title: 'Econômetro',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
