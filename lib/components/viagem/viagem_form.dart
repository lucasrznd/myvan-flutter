import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myvan_flutter/models/enums/tipo_viagem.dart';
import 'package:myvan_flutter/models/motorista.dart';
import 'package:myvan_flutter/models/tipo_veiculo.dart';
import 'package:myvan_flutter/models/veiculo.dart';

class ViagemForm extends StatefulWidget {
  final void Function(Veiculo, Motorista, DateTime, TipoViagem, String)
      onSubmit;

  const ViagemForm(this.onSubmit, {Key? key}) : super(key: key);

  @override
  State<ViagemForm> createState() => _ViagemFormState();
}

class _ViagemFormState extends State<ViagemForm> {
  final _formKey = GlobalKey<FormState>();
  final _veiculoController = TextEditingController();
  final _motoristaController = TextEditingController();
  final _tipoviagemController = TextEditingController();
  final _nomeviagemController = TextEditingController();
  DateTime? _selectedDate;

  _submitForm() {
    final veiculo = _veiculoController.text;
    final motorista = _motoristaController.text;
    final tipoViagem = _tipoviagemController.text;

    if (veiculo.isEmpty ||
        motorista.isEmpty ||
        _selectedDate == null ||
        tipoViagem.isEmpty) {
      return;
    }

    widget.onSubmit(
      Veiculo(
          codigo: 01,
          capacidadePassageiros: 23,
          cor: 'Preta',
          placa: 'BRA19A2',
          tipoVeiculo: TipoVeiculo(codigo: 02, descricao: 'descricao')),
      Motorista(codigo: 03, nome: 'Sergio', telefone: '43999990000'),
      _selectedDate!,
      TipoViagem.IDA, // Aqui você usa uma constante do enum
      '', // Supondo que este campo será preenchido posteriormente
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Data inicial
      firstDate: DateTime(2000), // Data mínima
      lastDate: DateTime(2101), // Data máxima
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _veiculoController,
                  decoration: InputDecoration(
                    labelText: 'Veículo',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veículo é obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _motoristaController,
                  decoration: InputDecoration(
                    labelText: 'Motorista',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Motorista é obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => _selectDate(context),
                        child: Text(
                          _selectedDate == null
                              ? 'Selecionar Data'
                              : DateFormat('dd/MM/yyyy').format(_selectedDate!),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _tipoviagemController,
                  decoration: InputDecoration(
                    labelText: 'Tipo de Viagem',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tipo de Viagem é obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _nomeviagemController,
                  decoration: InputDecoration(
                    labelText: 'Nome da Viagem',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nome da Viagem é obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateColor.resolveWith((states) => Colors.blue),
                    shape: MaterialStateProperty.resolveWith(
                      (states) => RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Salvar',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _submitForm();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}