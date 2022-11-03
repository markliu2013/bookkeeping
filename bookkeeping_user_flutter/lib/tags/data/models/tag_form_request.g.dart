// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_form_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagFormRequest _$TagFormRequestFromJson(Map<String, dynamic> json) =>
    TagFormRequest(
      name: json['name'] as String?,
      notes: json['notes'] as String?,
      parentId: json['parentId'] as String?,
      expenseable: json['expenseable'] as bool?,
      incomeable: json['incomeable'] as bool?,
      transferable: json['transferable'] as bool?,
    );

Map<String, dynamic> _$TagFormRequestToJson(TagFormRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'notes': instance.notes,
      'parentId': instance.parentId,
      'expenseable': instance.expenseable,
      'incomeable': instance.incomeable,
      'transferable': instance.transferable,
    };
