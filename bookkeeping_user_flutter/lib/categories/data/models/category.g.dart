// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['id'] as int,
      name: json['name'] as String,
      notes: json['notes'] as String?,
      enable: json['enable'] as bool,
      parentId: json['parentId'] as int?,
      parentName: json['parentName'] as String?,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'notes': instance.notes,
      'enable': instance.enable,
      'parentId': instance.parentId,
      'parentName': instance.parentName,
    };
