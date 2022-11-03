// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_tree.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryTree _$CategoryTreeFromJson(Map<String, dynamic> json) => CategoryTree(
      id: json['id'] as int,
      name: json['name'] as String,
      notes: json['notes'] as String?,
      enable: json['enable'] as bool,
      parentId: json['parentId'] as int?,
      parentName: json['parentName'] as String?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => CategoryTree.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryTreeToJson(CategoryTree instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'notes': instance.notes,
      'enable': instance.enable,
      'parentId': instance.parentId,
      'parentName': instance.parentName,
      'children': instance.children,
    };
