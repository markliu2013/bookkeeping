// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transfer _$TransferFromJson(Map<String, dynamic> json) => Transfer(
      id: json['id'] as int,
      amount: json['amount'] as num,
      convertedAmount: json['convertedAmount'] as num,
      from: IdNameModel.fromJson(json['from'] as Map<String, dynamic>),
      to: IdNameModel.fromJson(json['to'] as Map<String, dynamic>),
      accountName: json['accountName'] as String,
      createTime: json['createTime'] as int,
      description: json['description'] as String?,
      notes: json['notes'] as String?,
      status: json['status'] as int,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TransferToJson(Transfer instance) => <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'convertedAmount': instance.convertedAmount,
      'from': instance.from,
      'to': instance.to,
      'accountName': instance.accountName,
      'createTime': instance.createTime,
      'description': instance.description,
      'notes': instance.notes,
      'status': instance.status,
      'tags': instance.tags,
    };
