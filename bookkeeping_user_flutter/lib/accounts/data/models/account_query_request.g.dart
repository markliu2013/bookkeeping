// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_query_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountQueryRequest _$AccountQueryRequestFromJson(Map<String, dynamic> json) =>
    AccountQueryRequest(
      type: json['type'] as int? ?? 1,
      page: json['page'] as int? ?? 1,
      size: json['size'] as int? ?? 10,
      sort: json['sort'] as String? ?? '',
    );

Map<String, dynamic> _$AccountQueryRequestToJson(
        AccountQueryRequest instance) =>
    <String, dynamic>{
      'type': instance.type,
      'page': instance.page,
      'size': instance.size,
      'sort': instance.sort,
    };
