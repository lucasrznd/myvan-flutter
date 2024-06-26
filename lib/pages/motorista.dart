import 'package:flutter/material.dart';
import 'package:myvan_flutter/components/drawer/sidemenu.dart';
import 'package:myvan_flutter/components/motorista/motorista_form.dart';
import 'package:myvan_flutter/components/motorista/motorista_list.dart';
import 'package:myvan_flutter/components/utils/modal_mensagens.dart';
import 'package:myvan_flutter/models/motorista.dart';
import 'package:myvan_flutter/services/motorista_service.dart';

class MotoristaPage extends StatefulWidget {
  const MotoristaPage({super.key});

  @override
  State<MotoristaPage> createState() => _MotoristaPageState();
}

class _MotoristaPageState extends State<MotoristaPage> {
  late Future<List<Motorista>> _motoristas;
  late Motorista _motorista;

  late MotoristaService service;

  @override
  void initState() {
    super.initState();
    service = MotoristaService();
    _motoristas = selectAll();
  }

  Future<List<Motorista>> selectAll() {
    return service.selectAll();
  }

  _salvarMotorista(Motorista motorista) {
    service.insert(motorista);

    setState(() {
      _motoristas = selectAll();
    });

    Navigator.of(context).pop();

    ModalMensagem.modalSucesso(context, 'Motorista', 'o');
  }

  _editarMotorista(Motorista motorista) {
    setState(() {
      _openFormModal(context, motorista);
    });
  }

  _deleteMotorista(int codigo) async {
    bool opcao =
        await ModalMensagem.modalConfirmDelete(context, 'Motorista', 'o');

    if (opcao) {
      await service.delete(codigo);

      setState(() {
        _motoristas = selectAll();
      });
    }
  }

  _openFormModal(BuildContext context, Motorista motorista) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return MotoristaForm(_salvarMotorista, motorista);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _motorista = Motorista();

    final appBar = AppBar(
      title: const Text('Motoristas'),
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue.shade300,
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _openFormModal(context, _motorista),
        ),
      ],
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const SideMenu(),
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: availableHeight * 0.6,
              child: MotoristaList(
                _motoristas,
                _editarMotorista,
                _deleteMotorista,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openFormModal(context, _motorista),
        backgroundColor: Colors.blue.shade300,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
