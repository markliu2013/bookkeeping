// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deal_add_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DealAddRequest _$DealAddRequestFromJson(Map<String, dynamic> json) =>
    DealAddRequest(
      description: json['description'] as String?,
      createTime: json['createTime'] as int?,
      accountId: json['accountId'] as String?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) =>
              CategoryIdAmountRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      payeeId: json['payeeId'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      confirmed: json['confirmed'] as bool?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$DealAddRequestToJson(DealAddRequest instance) =>
    <String, dynamic>{
      'description': instance.description,
      'createTime': instance.createTime,
      'accountId': instance.accountId,
      'categories': instance.categories,
      'payeeId': instance.payeeId,
      'tags': instance.tags,
      'confirmed': instance.confirmed,
      'notes': instance.notes,
    };

CategoryIdAmountRequest _$CategoryIdAmountRequestFromJson(
        Map<String, dynamic> json) =>
    CategoryIdAmountRequest(
      categoryId: json['categoryId'] as String,
      categoryName: json['categoryName'] as String,
      amount: json['amount'] as num,
      convertedAmount: json['convertedAmount'] as num?,
    );

Map<String, dynamic> _$CategoryIdAmountRequestToJson(
        CategoryIdAmountRequest instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'amount': instance.amount,
      'convertedAmount': instance.convertedAmount,
    };
