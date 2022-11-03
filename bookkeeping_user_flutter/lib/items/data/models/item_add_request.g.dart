// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_add_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemAddRequest _$ItemAddRequestFromJson(Map<String, dynamic> json) =>
    ItemAddRequest(
      title: json['title'] as String,
      notes: json['notes'] as String?,
      startDate: json['startDate'] as int,
      endDate: json['endDate'] as int,
      repeatType: json['repeatType'] as int,
      interval: json['interval'] as int,
    );

Map<String, dynamic> _$ItemAddRequestToJson(ItemAddRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'notes': instance.notes,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'repeatType': instance.repeatType,
      'interval': instance.interval,
    };
