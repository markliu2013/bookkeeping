// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_form_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountFormRequest _$AccountFormRequestFromJson(Map<String, dynamic> json) =>
    AccountFormRequest(
      currencyCode: json['currencyCode'] as String?,
      name: json['name'] as String?,
      no: json['no'] as String?,
      balance: json['balance'] as String?,
      include: json['include'] as bool?,
      transferFromAble: json['transferFromAble'] as bool?,
      transferToAble: json['transferToAble'] as bool?,
      expenseable: json['expenseable'] as bool?,
      incomeable: json['incomeable'] as bool?,
      notes: json['notes'] as String?,
      limit: json['limit'] as String?,
      billDay: json['billDay'] as String?,
      apr: json['apr'] as String?,
    );

Map<String, dynamic> _$AccountFormRequestToJson(AccountFormRequest instance) =>
    <String, dynamic>{
      'currencyCode': instance.currencyCode,
      'name': instance.name,
      'no': instance.no,
      'balance': instance.balance,
      'include': instance.include,
      'transferFromAble': instance.transferFromAble,
      'transferToAble': instance.transferToAble,
      'expenseable': instance.expenseable,
      'incomeable': instance.incomeable,
      'notes': instance.notes,
      'limit': instance.limit,
      'billDay': instance.billDay,
      'apr': instance.apr,
    };
