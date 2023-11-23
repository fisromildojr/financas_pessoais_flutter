import 'package:objectbox/objectbox.dart';

abstract class AbstractEntity {
  int? id;
  String? createdAt;
  String? updatedAt;
  
  Map<String, dynamic> toMap();
  
}
