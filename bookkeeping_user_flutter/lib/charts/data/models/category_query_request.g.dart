// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_query_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryQueryRequest _$CategoryQueryRequestFromJson(
        Map<String, dynamic> json) =>
    CategoryQueryRequest(
      minTime: json['minTime'] as int?,
      maxTime: json['maxTime'] as int?,
      categoryId: json['categoryId'] as String?,
    );

Map<String, dynamic> _$CategoryQueryRequestToJson(
        CategoryQueryRequest instance) =>
    <String, dynamic>{
      'minTime': instance.minTime,
      'maxTime': instance.maxTime,
      'categoryId': instance.categoryId,
    };
