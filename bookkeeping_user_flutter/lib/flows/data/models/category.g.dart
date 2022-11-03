// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['id'] as int,
      amount: json['amount'] as num,
      convertedAmount: json['convertedAmount'] as num,
      categoryId: json['categoryId'] as int,
      categoryName: json['categoryName'] as String,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'convertedAmount': instance.convertedAmount,
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
    };
