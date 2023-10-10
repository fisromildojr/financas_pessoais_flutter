import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:financas_pessoais_flutter/modules/abstract/models/abstract_entity_model.dart';
import 'package:financas_pessoais_flutter/services/http_service.dart';
import 'package:financas_pessoais_flutter/utils/back_routes.dart';
import 'package:http/http.dart' as http;

class CategoriaRepository implements HttpService {
  @override
  Future<AbstractEntity?> delete(String url, AbstractEntity entity) async {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> getAll(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha na requisição...');
    }
  }

  @override
  Future<AbstractEntity?> save(String url, AbstractEntity entity) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future<AbstractEntity?> update(String url, AbstractEntity entity) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
