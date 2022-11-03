// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tag _$TagFromJson(Map<String, dynamic> json) => Tag(
      id: json['id'] as int,
      name: json['name'] as String,
      enable: json['enable'] as bool,
      parentId: json['parentId'] as int?,
      parentName: json['parentName'] as String?,
      expenseable: json['expenseable'] as bool,
      incomeable: json['incomeable'] as bool,
      transferable: json['transferable'] as bool,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'notes': instance.notes,
      'enable': instance.enable,
      'parentId': instance.parentId,
      'parentName': instance.parentName,
      'expenseable': instance.expenseable,
      'incomeable': instance.incomeable,
      'transferable': instance.transferable,
    };
