// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_form_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryFormRequest _$CategoryFormRequestFromJson(Map<String, dynamic> json) =>
    CategoryFormRequest(
      name: json['name'] as String?,
      notes: json['notes'] as String?,
      parentId: json['parentId'] as String?,
    );

Map<String, dynamic> _$CategoryFormRequestToJson(
        CategoryFormRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'notes': instance.notes,
      'parentId': instance.parentId,
    };
