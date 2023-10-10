import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:financas_pessoais_flutter/modules/categoria/models/categoria_model.dart';
import 'package:financas_pessoais_flutter/modules/categoria/repository/categoria_repository.dart';
import 'package:financas_pessoais_flutter/utils/back_routes.dart';
import 'package:flutter/material.dart';

class CategoriaListPage extends StatelessWidget {
  CategoriaListPage({super.key});

  // Future<List<Categoria>?> findAll() async {
  //   var categoriaRepository = CategoriaRepository();
  //   try {
  //     final response = await categoriaRepository
  //         .getAll(BackRoutes.baseUrl + BackRoutes.CATEGORIA_ALL);
  //     if (response != null) {
  //       List<Categoria> categorias =
  //           response.map<Categoria>((e) => Categoria.fromMap(e)).toList();
  //       return categorias;
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  var categorias = [
    Categoria(
      nome: "FARMACIA",
    ),
    Categoria(
      nome: "MERCADO",
    ),
  ];

  Future<List<Categoria>> findAll() async {
    return Future.delayed(const Duration(seconds: 1), () => categorias);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
      ),
      body: FutureBuilder(
          future: findAll(),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              List<Categoria> data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (ctx, index) => ListTile(
                  title: Text(data[index].nome),
                ),
              );
            } else {
              return const Center(
                child: Text("Erro ao buscar categorias..."),
              );
            }
          }),
    );
  }
}
