// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_query_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemQueryRequest _$ItemQueryRequestFromJson(Map<String, dynamic> json) =>
    ItemQueryRequest(
      page: json['page'] as int? ?? 1,
      size: json['size'] as int? ?? 10,
      sort: json['sort'] as String? ?? '',
    );

Map<String, dynamic> _$ItemQueryRequestToJson(ItemQueryRequest instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
      'sort': instance.sort,
    };
