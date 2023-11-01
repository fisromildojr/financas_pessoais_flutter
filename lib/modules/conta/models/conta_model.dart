// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:financas_pessoais_flutter/modules/abstract/models/abstract_entity_model.dart';
import 'package:financas_pessoais_flutter/modules/categoria/models/categoria_model.dart';

class Conta extends AbstractEntity {
  Categoria categoria;
    bool tipo;
    String data;
    String descricao;
    double valor;
    String destinoOrigem;
    bool status;

  Conta({
    required this.categoria,
    required this.tipo,
    required this.data,
    required this.descricao,
    required this.valor,
    required this.destinoOrigem,
    required this.status,
  });

@override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'categoria': categoria.toMap(),
    'tipo': tipo,
    'data': data,
    'descricao': descricao,
    'valor': valor,
    'destinoOrigem': destinoOrigem,
    'status': status, 
    };
  }

  factory Conta.fromMap(Map<String, dynamic> map) {
    return Conta(
      categoria: Categoria.fromMap(map['categoria'] as Map<String, dynamic>),
      tipo: map['tipo'] as bool,
data:map['data'] as String,
descricao:map['descricao'] as String,
valor:map['valor'] as double,
destinoOrigem: map['destinoOrigem'] as String,
status:map['status'] as bool,
    )..id = map['id'] == null ? null : map['id'] as int;
  }

}
