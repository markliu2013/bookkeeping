// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      id: json['id'] as int,
      title: json['title'] as String,
      notes: json['notes'] as String?,
      nextDate: json['nextDate'] as int,
      countDown: json['countDown'] as int,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'notes': instance.notes,
      'nextDate': instance.nextDate,
      'countDown': instance.countDown,
    };
