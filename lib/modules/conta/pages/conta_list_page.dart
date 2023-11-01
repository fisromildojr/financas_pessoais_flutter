import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:financas_pessoais_flutter/modules/conta/controllers/conta_controller.dart';
import 'package:financas_pessoais_flutter/modules/conta/models/conta_model.dart';
import 'package:financas_pessoais_flutter/modules/conta/repository/conta_repository.dart';
import 'package:financas_pessoais_flutter/modules/conta/controllers/conta_controller.dart';
import 'package:financas_pessoais_flutter/modules/conta/models/conta_model.dart';
import 'package:financas_pessoais_flutter/utils/back_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContaListPage extends StatelessWidget {
  ContaListPage({super.key});

  @override
  Widget build(BuildContext context) {

  // final controller = Provider.of<ContaController>(context);
  final controller = context.watch<ContaController>();

  // final controller = Provider.of<ContaController>(context, listen: false);
  // final controller = context.read<ContaController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contas'),
      ),
      body: FutureBuilder(
          future: controller.findAll(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                List<Conta> data = snapshot.data!;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (ctx, index) => Card(
                    child: ListTile(
                      title: Text(data[index].descricao),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: ()=>controller.edit(context,data[index]), 
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.amber,
                            ),
                          ),
                          IconButton(
                            onPressed: ()=>controller.delete(data[index]), 
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: Text("Erro ao buscar contas..."),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.create(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
