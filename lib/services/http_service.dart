import 'package:financas_pessoais_flutter/modules/abstract/models/abstract_entity_model.dart';

abstract class HttpService {
  Future<dynamic> getAll(String url);
  Future<AbstractEntity?> save(String url, AbstractEntity entity);
  Future<AbstractEntity?> update(String url, AbstractEntity entity);
  Future<AbstractEntity?> delete(String url, AbstractEntity entity);
}
