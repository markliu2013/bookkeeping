// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payee_query_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayeeQueryRequest _$PayeeQueryRequestFromJson(Map<String, dynamic> json) =>
    PayeeQueryRequest(
      page: json['page'] as int? ?? 1,
      size: json['size'] as int? ?? 15,
      sort: json['sort'] as String? ?? 'id,desc',
    );

Map<String, dynamic> _$PayeeQueryRequestToJson(PayeeQueryRequest instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
      'sort': instance.sort,
    };
