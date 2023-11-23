// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:financas_pessoais_flutter/database/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:objectbox/objectbox.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

import 'package:financas_pessoais_flutter/database/objectbox_database.dart';
import 'package:financas_pessoais_flutter/modules/categoria/controllers/categoria_controller.dart';
import 'package:financas_pessoais_flutter/modules/categoria/models/categoria_model.dart';
import 'package:financas_pessoais_flutter/modules/conta/models/conta_model.dart';
import 'package:financas_pessoais_flutter/modules/conta/repository/conta_repository.dart';
import 'package:financas_pessoais_flutter/utils/back_routes.dart';
import 'package:financas_pessoais_flutter/utils/utils.dart';
import 'package:financas_pessoais_flutter/utils/validators.dart';

class ContaController extends ChangeNotifier {
  List<Conta> contas = [];
  Categoria? categoriaSelecionada;
  String tipoSelecionado = 'Despesa';
  String groupValueTipoConta = "TipoConta";
  final dataController = TextEditingController();
  final descricaoController = TextEditingController();
  final valorController = TextEditingController();
  final destinoOrigemController = TextEditingController();
  
  Future<Box<Conta>> getBox() async {
    final store = 
      await ObjectBoxDatabase.getStore();
    
    return store.box<Conta>();
  }
  
  Future<List<Conta>?> findAll() async {
    try {
        final box = await getBox();
        contas = box.getAll();

        return contas;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<ResumoDTO?> resumo() async {
    final box = await getBox();

    final queryDespesa = box.query(
      Conta_.tipo.equals(true))
        .order(Conta_.id).build();

    final queryReceita = box.query(
      Conta_.tipo.equals(false))
        .order(Conta_.id).build();

    final contasDespesas = queryDespesa.find();
    final contasReceitas = queryReceita.find();
    
    queryDespesa.close();
    queryReceita.close();

    double totalDespesa = 0.0;
    double totalReceita = 0.0;
    double saldo = 0.0;

    contasDespesas.forEach((element) {
      totalDespesa += element.valor ?? 0.0;
    });

    contasReceitas.forEach((element) {
      totalReceita += element.valor ?? 0.0;
    });

    saldo = totalReceita - totalDespesa;

    return ResumoDTO(
      totalReceita: totalReceita, 
      totalDespesa: totalDespesa, 
      saldo: saldo,
    );

  }

  Future<void> save(Conta conta) async {
    try {
        final box = await getBox();
        box.put(conta);
        contas.add(conta);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> selecionarData(BuildContext context) async {
    final DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(
        Duration(days: 100),
      ),
    );
    if (dataSelecionada != null) {
      dataController.text = DateFormat('dd/MM/yyyy').format(dataSelecionada);
    }
  }

  Future<void> update(Conta conta) async {
    try {
        final box = await getBox();
        box.put(conta);
        contas.add(conta);
    } catch (e) {
      log(e.toString());
    }
  }

  create(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Nova Conta',
          textAlign: TextAlign.center,
        ),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField(
                  items: const [
                    DropdownMenuItem<String>(
                      value: 'Despesa',
                      child: Text('Despesa'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Receita',
                      child: Text('Receita'),
                    ),
                  ],
                  onChanged: (value) {
                    tipoSelecionado = value ?? 'Despesa';
                    notifyListeners();
                  },
                  decoration: InputDecoration(
                        hintText: 'Tipo',
                      ),
                  
                  validator: (value) {
                        if(value == null){
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                ),
                FutureBuilder<List<Categoria>?>(
                  future: context.read<CategoriaController>().findAll(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.done){
                      var categorias = snapshot.data ?? [];

                    return DropdownButtonFormField(
                      items: categorias.map((e) => 
                      DropdownMenuItem<Categoria>(
                          value: e,
                          child: Text(e.nome ?? '-'),
                        ),
                      ).toList(),
                      onChanged: (value) {
                        categoriaSelecionada = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Categorias',
                      ),
                      validator: (value) {
                        if(value == null){
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    );
                    }
                    return const CircularProgressIndicator();
                  }
                ),
                TextFormField(
                  onTap: () => selecionarData(context),
                  readOnly: true,
                  controller: dataController,
                  decoration: InputDecoration(labelText: Provider.of<ContaController>(context).tipoSelecionado == 'Despesa' ? 'Data de Pagamento' : 'Data de Recebimento'),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    DataInputFormatter(),
                  ],
                ),
                TextFormField(
                  controller: descricaoController,
                  decoration: InputDecoration(labelText: 'Descrição'),
                ),
                TextFormField(
                  controller: destinoOrigemController,
                  decoration: InputDecoration(labelText: Provider.of<ContaController>(context).tipoSelecionado == 'Despesa' ? 'Destino' : 'Origem'),
                ),
                TextFormField(
                  controller: valorController,
                  decoration: InputDecoration(labelText: 'Valor'),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CentavosInputFormatter(moeda: true),
                  ],
                  validator: Validatorless.multiple([
                    Validatorless.required('Campo obrigatório'),
                    Validators.minDouble(0.01, 'Valor inválido'),
                  ]),
                  // validator: (value) {
                  //   if(value == null || value.isEmpty){
                  //     return "Campo obrigatório";
                  //   }
                  //   return null;
                  // },
                ),
                
                
              ],
            ),
          ),
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () async {
              if (formKey.currentState?.validate() ?? false) {
                var conta = Conta( 
                  tipo: tipoSelecionado == 'Despesa' ? true : false, 
                  data: Utils.convertDate(dataController.text),
                  descricao: descricaoController.text, 
                  valor: UtilBrasilFields.converterMoedaParaDouble(valorController.text), 
                  destinoOrigem: destinoOrigemController.text, 
                  status: false,
                );
                conta.categoria.target = categoriaSelecionada!;
                await save(conta);
                notifyListeners();
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.save),
            label: const Text('Salvar'),
          )
        ],
      ),
    );
  }

  edit(BuildContext context, Conta data) {
    final formKey = GlobalKey<FormState>();
    // final _nomeController = TextEditingController(text: data.nome);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Editar Conta',
          textAlign: TextAlign.center,
        ),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                // controller: _nomeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () async {
              if (formKey.currentState?.validate() ?? false) {
                // data.nome = _nomeController.text;
                await update(data);
                notifyListeners();
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.save),
            label: const Text('Atualizar'),
          )
        ],
      ),
    );
  }

  delete(Conta data)async {
    try {
      final box = await getBox();
      box.remove(data.id!);
      contas.remove(data);
    } catch (e) {
      log(e.toString());
    }
  }
}

class ResumoDTO {
  double totalReceita;
  double totalDespesa;
  double saldo;
  ResumoDTO({
    required this.totalReceita,
    required this.totalDespesa,
    required this.saldo,
  });
}
