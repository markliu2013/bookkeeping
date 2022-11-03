// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_tree.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagTree _$TagTreeFromJson(Map<String, dynamic> json) => TagTree(
      id: json['id'] as int,
      name: json['name'] as String,
      notes: json['notes'] as String?,
      enable: json['enable'] as bool,
      parentId: json['parentId'] as int?,
      parentName: json['parentName'] as String?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => TagTree.fromJson(e as Map<String, dynamic>))
          .toList(),
      expenseable: json['expenseable'] as bool,
      incomeable: json['incomeable'] as bool,
      transferable: json['transferable'] as bool,
    );

Map<String, dynamic> _$TagTreeToJson(TagTree instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'notes': instance.notes,
      'enable': instance.enable,
      'parentId': instance.parentId,
      'parentName': instance.parentName,
      'children': instance.children,
      'expenseable': instance.expenseable,
      'incomeable': instance.incomeable,
      'transferable': instance.transferable,
    };
