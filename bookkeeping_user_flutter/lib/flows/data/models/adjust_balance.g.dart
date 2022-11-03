// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adjust_balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdjustBalance _$AdjustBalanceFromJson(Map<String, dynamic> json) =>
    AdjustBalance(
      id: json['id'] as int,
      amount: json['amount'] as num,
      account: json['account'] == null
          ? null
          : IdNameModel.fromJson(json['account'] as Map<String, dynamic>),
      accountName: json['accountName'] as String,
      createTime: json['createTime'] as int,
      description: json['description'] as String?,
      notes: json['notes'] as String?,
      status: json['status'] as int,
    );

Map<String, dynamic> _$AdjustBalanceToJson(AdjustBalance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'account': instance.account,
      'accountName': instance.accountName,
      'createTime': instance.createTime,
      'description': instance.description,
      'notes': instance.notes,
      'status': instance.status,
    };
