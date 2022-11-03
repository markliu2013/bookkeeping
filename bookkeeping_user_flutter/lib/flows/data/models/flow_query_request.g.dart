// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flow_query_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlowQueryRequest _$FlowQueryRequestFromJson(Map<String, dynamic> json) =>
    FlowQueryRequest(
      payees:
          (json['payees'] as List<dynamic>?)?.map((e) => e as String).toList(),
      type: json['type'] as String?,
      accountId: json['accountId'] as String?,
      status: json['status'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      minTime: json['minTime'] as int?,
      maxTime: json['maxTime'] as int?,
      page: json['page'] as int? ?? 1,
      size: json['size'] as int? ?? 10,
      sort: json['sort'] as String? ?? 'createTime,desc',
    );

Map<String, dynamic> _$FlowQueryRequestToJson(FlowQueryRequest instance) =>
    <String, dynamic>{
      'payees': instance.payees,
      'type': instance.type,
      'accountId': instance.accountId,
      'status': instance.status,
      'tags': instance.tags,
      'categories': instance.categories,
      'minTime': instance.minTime,
      'maxTime': instance.maxTime,
      'page': instance.page,
      'size': instance.size,
      'sort': instance.sort,
    };
