import 'package:financas_pessoais_flutter/modules/abstract/models/abstract_entity_model.dart';

abstract class HttpService {
  Future<dynamic> getAll(String url);
  Future<dynamic> save(String url, AbstractEntity entity);
  Future<dynamic> update(String url, AbstractEntity entity);
  Future<dynamic> delete(String url, AbstractEntity entity);
}
