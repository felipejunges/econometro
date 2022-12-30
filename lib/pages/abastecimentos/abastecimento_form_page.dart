import 'package:econometro/models/abastecimento.dart';
import 'package:econometro/models/abastecimento_form.dart';
import 'package:econometro/services/abastecimento_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:date_time_picker/date_time_picker.dart';

class AbastecimentoFormPage extends StatelessWidget {
  AbastecimentoFormPage({super.key, this.abastecimento});

  final _globalKey = GlobalKey<FormState>();
  //final _dataController = TextEditingController();

  final _model = AbastecimentoForm();
  final Abastecimento? abastecimento;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dados do abastecimento'),
        actions: [
          IconButton(onPressed: () => _salvar(context), icon: const Icon(Icons.save)),
        ],
      ),
      body: _form(context),
    );
  }

  Widget _form(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _globalKey,
        child: ListView(
          children: _camposForm(context),
        ),
      ),
    );
  }

  List<Widget> _camposForm(context) {
    return [
      DateTimePicker(
        decoration: const InputDecoration(
          icon: Icon(Icons.calendar_today),
          labelText: "Data",
        ),
        initialValue: abastecimento == null ? null : DateFormat('yyyy-MM-dd').format(abastecimento!.data),
        dateMask: 'yyyy-MM-dd',
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        dateLabelText: 'Data',
        onChanged: (value) => print(value),
        validator: (value) {
          print(value);
          return null;
        },
        onSaved: (value) => _model.data = value == null ? null : DateFormat('yyyy-MM-dd').parse(value),
      ),
      TextFormField(
        decoration: const InputDecoration(
          icon: Icon(Icons.speed_rounded),
          labelText: "KM",
        ),
        keyboardType: TextInputType.number,
        initialValue: abastecimento?.km.toString(),
        onSaved: (value) => _model.km = value == null ? null : int.parse(value),
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'A KM deve ser informada';
          }
          if (int.tryParse(value!) == null) {
            return 'A KM deve ser um número';
          }
          return null;
        },
      ),
      TextFormField(
        decoration: const InputDecoration(
          icon: Icon(Icons.local_gas_station),
          labelText: "Litros",
        ),
        keyboardType: TextInputType.number,
        initialValue: abastecimento?.litros.toString(),
        onSaved: (value) => _model.litros = value == null ? null : double.parse(value),
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'Os litros devem ser informados';
          }
          if (double.tryParse(value!) == null) {
            return 'Os litros devem ser um número';
          }
          return null;
        },
      ),
      TextFormField(
        decoration: const InputDecoration(
          icon: Icon(Icons.monetization_on_outlined),
          labelText: "\$/litro",
        ),
      )
    ];
  }

  _salvar(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();

    if (_globalKey.currentState?.validate() ?? false) {
      _globalKey.currentState?.save();

      if (abastecimento?.id != null) {
        _model.id = abastecimento!.id;
      }

      Provider.of<AbastecimentoProvider>(context, listen: false)
          .save(
            _model.toAbastecimento(),
          )
          .then(
            (value) => Navigator.pop(context),
          );
    }
  }
}
