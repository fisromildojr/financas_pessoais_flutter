// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import '../modules/categoria/models/categoria_model.dart';
import '../modules/conta/models/conta_model.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 2583534346573981555),
      name: 'Categoria',
      lastPropertyId: const IdUid(4, 3634100010930685699),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3068845099696719569),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 6836886648072699054),
            name: 'createdAt',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 6668499849584700269),
            name: 'updatedAt',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 3634100010930685699),
            name: 'nome',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 2463472167513307164),
      name: 'Conta',
      lastPropertyId: const IdUid(10, 5029920952117432263),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3147038100698850152),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 787068010971719215),
            name: 'createdAt',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 8340239172536399700),
            name: 'updatedAt',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 7058587698458180809),
            name: 'categoriaId',
            type: 11,
            flags: 520,
            indexId: const IdUid(1, 5138059861942278447),
            relationTarget: 'Categoria'),
        ModelProperty(
            id: const IdUid(5, 4708110720115459934),
            name: 'tipo',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 7627294048124838464),
            name: 'data',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 7789277178099556662),
            name: 'descricao',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 2566504007109941240),
            name: 'valor',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 5228401026857735310),
            name: 'destinoOrigem',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 5029920952117432263),
            name: 'status',
            type: 1,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Shortcut for [Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [Store.new] for an explanation of all parameters.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// Returns the ObjectBox model definition for this project for use with
/// [Store.new].
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(2, 2463472167513307164),
      lastIndexId: const IdUid(1, 5138059861942278447),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Categoria: EntityDefinition<Categoria>(
        model: _entities[0],
        toOneRelations: (Categoria object) => [],
        toManyRelations: (Categoria object) => {},
        getId: (Categoria object) => object.id,
        setId: (Categoria object, int id) {
          object.id = id;
        },
        objectToFB: (Categoria object, fb.Builder fbb) {
          final createdAtOffset = object.createdAt == null
              ? null
              : fbb.writeString(object.createdAt!);
          final updatedAtOffset = object.updatedAt == null
              ? null
              : fbb.writeString(object.updatedAt!);
          final nomeOffset =
              object.nome == null ? null : fbb.writeString(object.nome!);
          fbb.startTable(5);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, createdAtOffset);
          fbb.addOffset(2, updatedAtOffset);
          fbb.addOffset(3, nomeOffset);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 4);
          final createdAtParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 6);
          final updatedAtParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 8);
          final nomeParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 10);
          final object = Categoria(
              id: idParam,
              createdAt: createdAtParam,
              updatedAt: updatedAtParam,
              nome: nomeParam);

          return object;
        }),
    Conta: EntityDefinition<Conta>(
        model: _entities[1],
        toOneRelations: (Conta object) => [object.categoria],
        toManyRelations: (Conta object) => {},
        getId: (Conta object) => object.id,
        setId: (Conta object, int id) {
          object.id = id;
        },
        objectToFB: (Conta object, fb.Builder fbb) {
          final createdAtOffset = object.createdAt == null
              ? null
              : fbb.writeString(object.createdAt!);
          final updatedAtOffset = object.updatedAt == null
              ? null
              : fbb.writeString(object.updatedAt!);
          final dataOffset =
              object.data == null ? null : fbb.writeString(object.data!);
          final descricaoOffset = object.descricao == null
              ? null
              : fbb.writeString(object.descricao!);
          final destinoOrigemOffset = object.destinoOrigem == null
              ? null
              : fbb.writeString(object.destinoOrigem!);
          fbb.startTable(11);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, createdAtOffset);
          fbb.addOffset(2, updatedAtOffset);
          fbb.addInt64(3, object.categoria.targetId);
          fbb.addBool(4, object.tipo);
          fbb.addOffset(5, dataOffset);
          fbb.addOffset(6, descricaoOffset);
          fbb.addFloat64(7, object.valor);
          fbb.addOffset(8, destinoOrigemOffset);
          fbb.addBool(9, object.status);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 4);
          final createdAtParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 6);
          final updatedAtParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 8);
          final tipoParam =
              const fb.BoolReader().vTableGetNullable(buffer, rootOffset, 12);
          final dataParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 14);
          final descricaoParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 16);
          final valorParam = const fb.Float64Reader()
              .vTableGetNullable(buffer, rootOffset, 18);
          final destinoOrigemParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 20);
          final statusParam =
              const fb.BoolReader().vTableGetNullable(buffer, rootOffset, 22);
          final object = Conta(
              id: idParam,
              createdAt: createdAtParam,
              updatedAt: updatedAtParam,
              tipo: tipoParam,
              data: dataParam,
              descricao: descricaoParam,
              valor: valorParam,
              destinoOrigem: destinoOrigemParam,
              status: statusParam);
          object.categoria.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0);
          object.categoria.attach(store);
          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Categoria] entity fields to define ObjectBox queries.
class Categoria_ {
  /// see [Categoria.id]
  static final id = QueryIntegerProperty<Categoria>(_entities[0].properties[0]);

  /// see [Categoria.createdAt]
  static final createdAt =
      QueryStringProperty<Categoria>(_entities[0].properties[1]);

  /// see [Categoria.updatedAt]
  static final updatedAt =
      QueryStringProperty<Categoria>(_entities[0].properties[2]);

  /// see [Categoria.nome]
  static final nome =
      QueryStringProperty<Categoria>(_entities[0].properties[3]);
}

/// [Conta] entity fields to define ObjectBox queries.
class Conta_ {
  /// see [Conta.id]
  static final id = QueryIntegerProperty<Conta>(_entities[1].properties[0]);

  /// see [Conta.createdAt]
  static final createdAt =
      QueryStringProperty<Conta>(_entities[1].properties[1]);

  /// see [Conta.updatedAt]
  static final updatedAt =
      QueryStringProperty<Conta>(_entities[1].properties[2]);

  /// see [Conta.categoria]
  static final categoria =
      QueryRelationToOne<Conta, Categoria>(_entities[1].properties[3]);

  /// see [Conta.tipo]
  static final tipo = QueryBooleanProperty<Conta>(_entities[1].properties[4]);

  /// see [Conta.data]
  static final data = QueryStringProperty<Conta>(_entities[1].properties[5]);

  /// see [Conta.descricao]
  static final descricao =
      QueryStringProperty<Conta>(_entities[1].properties[6]);

  /// see [Conta.valor]
  static final valor = QueryDoubleProperty<Conta>(_entities[1].properties[7]);

  /// see [Conta.destinoOrigem]
  static final destinoOrigem =
      QueryStringProperty<Conta>(_entities[1].properties[8]);

  /// see [Conta.status]
  static final status = QueryBooleanProperty<Conta>(_entities[1].properties[9]);
}
