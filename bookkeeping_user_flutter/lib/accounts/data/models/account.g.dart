// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      id: json['id'] as int,
      type: json['type'] as int,
      typeName: json['typeName'] as String,
      name: json['name'] as String,
      balance: (json['balance'] as num).toDouble(),
      currencyCode: json['currencyCode'] as String,
      convertedBalance: (json['convertedBalance'] as num?)?.toDouble(),
      enable: json['enable'] as bool,
      include: json['include'] as bool,
      expenseable: json['expenseable'] as bool,
      incomeable: json['incomeable'] as bool,
      transferFromAble: json['transferFromAble'] as bool,
      transferToAble: json['transferToAble'] as bool,
      initialBalance: (json['initialBalance'] as num).toDouble(),
      no: json['no'] as String?,
      notes: json['notes'] as String?,
      limit: (json['limit'] as num?)?.toDouble(),
      billDay: json['billDay'] as int?,
      remainLimit: (json['remainLimit'] as num?)?.toDouble(),
      apr: (json['apr'] as num?)?.toDouble(),
      asOfDate: json['asOfDate'] as int?,
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'typeName': instance.typeName,
      'name': instance.name,
      'no': instance.no,
      'balance': instance.balance,
      'currencyCode': instance.currencyCode,
      'convertedBalance': instance.convertedBalance,
      'enable': instance.enable,
      'include': instance.include,
      'expenseable': instance.expenseable,
      'incomeable': instance.incomeable,
      'transferFromAble': instance.transferFromAble,
      'transferToAble': instance.transferToAble,
      'initialBalance': instance.initialBalance,
      'notes': instance.notes,
      'limit': instance.limit,
      'billDay': instance.billDay,
      'remainLimit': instance.remainLimit,
      'apr': instance.apr,
      'asOfDate': instance.asOfDate,
    };
