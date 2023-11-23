import 'dart:developer';

import 'package:financas_pessoais_flutter/database/objectbox_database.dart';
import 'package:financas_pessoais_flutter/modules/categoria/models/categoria_model.dart';
import 'package:financas_pessoais_flutter/modules/categoria/repository/categoria_repository.dart';
import 'package:financas_pessoais_flutter/utils/back_routes.dart';
import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';

class CategoriaController extends ChangeNotifier {
  List<Categoria> categorias = [];

  Future<Box<Categoria>> getBox() async {
    final store = 
      await ObjectBoxDatabase.getStore();
    
    return store.box<Categoria>();
  }

  Future<List<Categoria>?> findAll() async {
    try {
        final box = await getBox();
        categorias = box.getAll();

        return categorias;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> save(Categoria categoria) async {
    try {
        final box = await getBox();
        box.put(categoria);
        categorias.add(categoria);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> update(Categoria categoria) async {
    try {
        final box = await getBox();
        box.put(categoria);
        categorias.add(categoria);
    } catch (e) {
      log(e.toString());
    }
  }

  create(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _nomeController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Nova Categoria',
          textAlign: TextAlign.center,
        ),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nomeController,
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
              if (_formKey.currentState?.validate() ?? false) {
                var categoria = Categoria(nome: _nomeController.text);
                await save(categoria);
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

  edit(BuildContext context, Categoria data) {
    final _formKey = GlobalKey<FormState>();
    final _nomeController = TextEditingController(text: data.nome);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Editar Categoria',
          textAlign: TextAlign.center,
        ),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nomeController,
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
              if (_formKey.currentState?.validate() ?? false) {
                data.nome = _nomeController.text;
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

  delete(Categoria data)async {
    try {
      final box = await getBox();
      box.remove(data.id!);
      categorias.remove(data);
    } catch (e) {
      log(e.toString());
    }
  }
}
