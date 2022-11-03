// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_query_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookQueryRequest _$BookQueryRequestFromJson(Map<String, dynamic> json) =>
    BookQueryRequest(
      page: json['page'] as int? ?? 1,
      size: json['size'] as int? ?? 10,
    );

Map<String, dynamic> _$BookQueryRequestToJson(BookQueryRequest instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
    };
