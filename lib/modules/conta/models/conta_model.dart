// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:objectbox/objectbox.dart';

import 'package:financas_pessoais_flutter/modules/categoria/models/categoria_model.dart';

@Entity()
class Conta {
  @Id()
  int? id;
  String? createdAt;
  String? updatedAt;
  final categoria = ToOne<Categoria>();
  bool? tipo;
  String? data;
  String? descricao;
  double? valor;
  String? destinoOrigem;
  bool? status;

  Conta({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.tipo,
    this.data,
    this.descricao,
    this.valor,
    this.destinoOrigem,
    this.status,
  });

}
