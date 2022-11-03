// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flow.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlowModel _$FlowModelFromJson(Map<String, dynamic> json) => FlowModel(
      id: json['id'] as int,
      amount: (json['amount'] as num).toDouble(),
      amountFormatted: json['amountFormatted'] as String,
      convertedAmount: (json['convertedAmount'] as num?)?.toDouble(),
      needConvert: json['needConvert'] as bool,
      toCurrencyCode: json['toCurrencyCode'] as String?,
      accountName: json['accountName'] as String?,
      title: json['title'] as String,
      subTitle: json['subTitle'] as String,
      createTime: json['createTime'] as int,
      createTimeFormatted: json['createTimeFormatted'] as String,
      description: json['description'] as String?,
      notes: json['notes'] as String?,
      categoryName: json['categoryName'] as String?,
      payee: json['payee'] == null
          ? null
          : IdNameModel.fromJson(json['payee'] as Map<String, dynamic>),
      status: json['status'] as int,
      statusName: json['statusName'] as String,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      tagsName: json['tagsName'] as String?,
      type: json['type'] as int,
      typeName: json['typeName'] as String,
      expense: json['expense'] == null
          ? null
          : Deal.fromJson(json['expense'] as Map<String, dynamic>),
      income: json['income'] == null
          ? null
          : Deal.fromJson(json['income'] as Map<String, dynamic>),
      transfer: json['transfer'] == null
          ? null
          : Transfer.fromJson(json['transfer'] as Map<String, dynamic>),
      adjustBalance: json['adjustBalance'] == null
          ? null
          : AdjustBalance.fromJson(
              json['adjustBalance'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FlowModelToJson(FlowModel instance) => <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'amountFormatted': instance.amountFormatted,
      'convertedAmount': instance.convertedAmount,
      'needConvert': instance.needConvert,
      'toCurrencyCode': instance.toCurrencyCode,
      'accountName': instance.accountName,
      'title': instance.title,
      'subTitle': instance.subTitle,
      'createTime': instance.createTime,
      'createTimeFormatted': instance.createTimeFormatted,
      'description': instance.description,
      'notes': instance.notes,
      'categoryName': instance.categoryName,
      'payee': instance.payee,
      'status': instance.status,
      'statusName': instance.statusName,
      'tags': instance.tags,
      'tagsName': instance.tagsName,
      'type': instance.type,
      'typeName': instance.typeName,
      'expense': instance.expense,
      'income': instance.income,
      'transfer': instance.transfer,
      'adjustBalance': instance.adjustBalance,
    };
