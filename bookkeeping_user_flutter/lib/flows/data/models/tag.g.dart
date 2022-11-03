// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tag _$TagFromJson(Map<String, dynamic> json) => Tag(
      id: json['id'] as int,
      amount: (json['amount'] as num).toDouble(),
      convertedAmount: (json['convertedAmount'] as num).toDouble(),
      tagId: json['tagId'] as int,
      tagName: json['tagName'] as String,
    );

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'convertedAmount': instance.convertedAmount,
      'tagId': instance.tagId,
      'tagName': instance.tagName,
    };
