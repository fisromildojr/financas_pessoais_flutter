import 'dart:convert';

import 'package:financas_pessoais_flutter/modules/abstract/models/abstract_entity_model.dart';
import 'package:financas_pessoais_flutter/services/http_service.dart';
import 'package:http/http.dart' as http;

class ContaRepository implements HttpService {
  @override
  Future<dynamic> delete(String url, AbstractEntity entity) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(entity.toMap()),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha na requisição...');
    }
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
  Future<dynamic> save(String url, AbstractEntity entity) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(entity.toMap()),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha na requisição...');
    }
  }

  @override
  Future<dynamic> update(String url, AbstractEntity entity) async{
    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(entity.toMap()),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha na requisição...');
    }
  }
}
