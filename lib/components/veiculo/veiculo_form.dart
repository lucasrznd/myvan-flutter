import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myvan_flutter/components/tipo_veiculo/dropdown.dart';
import 'package:myvan_flutter/models/tipo_veiculo.dart';
import 'package:myvan_flutter/models/veiculo.dart';

class VeiculoForm extends StatefulWidget {
  final void Function(Veiculo, TipoVeiculo) onSubmit;
  final Veiculo _veiculo;
  final Future<List<TipoVeiculo>> _tiposVeiculos;
  final TipoVeiculo _tipoVeiculo;

  const VeiculoForm(
      this.onSubmit, this._veiculo, this._tiposVeiculos, this._tipoVeiculo,
      {super.key});

  @override
  State<VeiculoForm> createState() => _VeiculoFormState();
}

class _VeiculoFormState extends State<VeiculoForm> {
  final _formKey = GlobalKey<FormState>();

  _submitForm() {
    widget.onSubmit(widget._veiculo, widget._tipoVeiculo);
  }

  @override
  void initState() {
    super.initState();
  }

  String formatarCapacidadePassageiros() {
    if (widget._veiculo.capacidadePassageiros == null) {
      return '';
    }
    return widget._veiculo.capacidadePassageiros.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10)
            .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: DropdownTipoVeiculo(
                      items: widget._tiposVeiculos,
                      hint: "Selecione uma opção",
                      initialValue:
                          widget._tipoVeiculo, // Always use initial value
                      onChanged: (newValue) {
                        setState(() {
                          if (newValue != null) {
                            widget._veiculo.tipoVeiculo = newValue.codigo!;
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              TextFormField(
                initialValue: widget._veiculo.placa,
                onChanged: (value) => widget._veiculo.placa = value,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  label: const Text('Placa Veículo'),
                ),
                inputFormatters: [PlacaVeiculoInputFormatter()],
                validator: (placa) {
                  if (placa == null || placa.isEmpty || placa == '') {
                    return 'Placa é obrigatória.';
                  }
                  return null;
                },
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              TextFormField(
                initialValue: widget._veiculo.cor,
                onChanged: (value) => widget._veiculo.cor = value,
                decoration: InputDecoration(
                  labelText: 'Cor',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (cor) {
                  if (cor == null || cor.isEmpty || cor == '') {
                    return 'Cor é obrigatória.';
                  }
                  return null;
                },
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              TextFormField(
                initialValue: formatarCapacidadePassageiros(),
                onChanged: (value) {
                  final parsedValue = int.tryParse(value);
                  if (parsedValue != null) {
                    widget._veiculo.capacidadePassageiros = parsedValue;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Capacidade de Passageiros',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.number,
                maxLength: 2,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ], // Only numbers can be entered
                validator: (capacidadePassageiros) {
                  if (capacidadePassageiros == null ||
                      capacidadePassageiros.isEmpty ||
                      capacidadePassageiros == '') {
                    return 'Capacidade de Passageiros é obrigatório.';
                  }
                  return null;
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.blue),
                      shape: MaterialStateProperty.resolveWith(
                        (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Salvar',
                      style:
                          TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _submitForm();
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
