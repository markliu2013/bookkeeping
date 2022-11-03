// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adjust_balance_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdjustBalanceRequest _$AdjustBalanceRequestFromJson(
        Map<String, dynamic> json) =>
    AdjustBalanceRequest(
      description: json['description'] as String?,
      createTime: json['createTime'] as int?,
      balance: json['balance'] as String?,
      convertedBalance: json['convertedBalance'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$AdjustBalanceRequestToJson(
        AdjustBalanceRequest instance) =>
    <String, dynamic>{
      'description': instance.description,
      'createTime': instance.createTime,
      'balance': instance.balance,
      'convertedBalance': instance.convertedBalance,
      'notes': instance.notes,
    };
