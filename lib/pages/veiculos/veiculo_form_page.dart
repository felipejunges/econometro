import 'package:econometro/models/veiculo_form.dart';
import 'package:econometro/services/veiculo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VeiculoFormPage extends StatelessWidget {
  VeiculoFormPage({super.key});

  final _globalKey = GlobalKey<FormState>();
  final _model = VeiculoForm();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dados do veículo'),
        actions: [
          IconButton(onPressed: () => _salvar(context), icon: const Icon(Icons.save)),
        ],
      ),
      body: _form(),
    );
  }

  Widget _form() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _globalKey,
        child: ListView(
          children: _camposForm(),
        ),
      ),
    );
  }

  List<Widget> _camposForm() {
    return [
      TextFormField(
        decoration: const InputDecoration(
          label: Text('Placa'),
        ),
        onSaved: (value) => _model.placa = value,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'A placa deve ser informada';
          }
          return null;
        },
      ),
      TextFormField(
        decoration: const InputDecoration(
          label: Text('Marca'),
        ),
        onSaved: (value) => _model.marca = value,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'A marca deve ser informada';
          }
          return null;
        },
      ),
      TextFormField(
        decoration: const InputDecoration(
          label: Text('Modelo'),
        ),
        onSaved: (value) => _model.modelo = value,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'O modelo deve ser informado';
          }
          return null;
        },
      ),
      TextFormField(
        decoration: const InputDecoration(
          label: Text('Ano'),
        ),
        keyboardType: TextInputType.number,
        onSaved: (value) => _model.modelo = value,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'O ano deve ser informado';
          }
          if (double.tryParse(value!) == null) {
            return 'O ano deve ser um número';
          }
          return null;
        },
      ),
    ];
  }

  void _salvar(context) {
    FocusManager.instance.primaryFocus?.unfocus();

    if (_globalKey.currentState?.validate() ?? false) {
      _globalKey.currentState?.save();

      Provider.of<VeiculoProvider>(context, listen: false)
          .insert(
            _model.toVeiculo(),
          )
          .then(
            (value) => Navigator.pop(context),
          );
    }
  }
}
