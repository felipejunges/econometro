import 'package:econometro/pages/abastecimentos/abastecimentos_page.dart';
import 'package:econometro/pages/veiculos/veiculos_page.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text("Felipe Junges"),
              accountEmail: Text("felipejunges@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "F",
                  style: TextStyle(
                    fontSize: 40.0,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.directions_car),
              title: const Text("Veículos"),
              subtitle: const Text("Uhmmm que interessante!"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const VeiculosPage()),
                ),
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_gas_station),
              title: const Text("Abastecimentos"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AbastecimentosPage()),
                ),
              },
            ),
            const Divider(),
            const Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Text('Bottom'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
