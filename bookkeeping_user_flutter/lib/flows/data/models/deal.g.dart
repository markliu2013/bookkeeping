// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Deal _$DealFromJson(Map<String, dynamic> json) => Deal(
      id: json['id'] as int,
      amount: json['amount'] as num,
      convertedAmount: json['convertedAmount'] as num,
      account: json['account'] == null
          ? null
          : IdNameModel.fromJson(json['account'] as Map<String, dynamic>),
      accountName: json['accountName'] as String?,
      createTime: json['createTime'] as int,
      description: json['description'] as String?,
      notes: json['notes'] as String?,
      status: json['status'] as int,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      categoryName: json['categoryName'] as String,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      payee: json['payee'] == null
          ? null
          : IdNameModel.fromJson(json['payee'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DealToJson(Deal instance) => <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'convertedAmount': instance.convertedAmount,
      'account': instance.account,
      'accountName': instance.accountName,
      'createTime': instance.createTime,
      'description': instance.description,
      'notes': instance.notes,
      'status': instance.status,
      'categories': instance.categories,
      'categoryName': instance.categoryName,
      'tags': instance.tags,
      'payee': instance.payee,
    };
