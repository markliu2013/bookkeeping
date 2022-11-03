// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_add_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferAddRequest _$TransferAddRequestFromJson(Map<String, dynamic> json) =>
    TransferAddRequest(
      description: json['description'] as String?,
      createTime: json['createTime'] as int?,
      fromId: json['fromId'] as String?,
      toId: json['toId'] as String?,
      amount: json['amount'] as num?,
      convertedAmount: json['convertedAmount'] as num?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      confirmed: json['confirmed'] as bool?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$TransferAddRequestToJson(TransferAddRequest instance) =>
    <String, dynamic>{
      'description': instance.description,
      'createTime': instance.createTime,
      'fromId': instance.fromId,
      'toId': instance.toId,
      'amount': instance.amount,
      'convertedAmount': instance.convertedAmount,
      'tags': instance.tags,
      'confirmed': instance.confirmed,
      'notes': instance.notes,
    };
