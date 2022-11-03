// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      id: json['id'] as int,
      name: json['name'] as String,
      group: IdNameModel.fromJson(json['group'] as Map<String, dynamic>),
      notes: json['notes'] as String?,
      descriptionEnable: json['descriptionEnable'] as bool,
      timeEnable: json['timeEnable'] as bool,
      imageEnable: json['imageEnable'] as bool,
      defaultExpenseAccount: json['defaultExpenseAccount'] == null
          ? null
          : IdNameModel.fromJson(
              json['defaultExpenseAccount'] as Map<String, dynamic>),
      defaultIncomeAccount: json['defaultIncomeAccount'] == null
          ? null
          : IdNameModel.fromJson(
              json['defaultIncomeAccount'] as Map<String, dynamic>),
      defaultTransferFromAccount: json['defaultTransferFromAccount'] == null
          ? null
          : IdNameModel.fromJson(
              json['defaultTransferFromAccount'] as Map<String, dynamic>),
      defaultTransferToAccount: json['defaultTransferToAccount'] == null
          ? null
          : IdNameModel.fromJson(
              json['defaultTransferToAccount'] as Map<String, dynamic>),
      defaultExpenseCategory: json['defaultExpenseCategory'] == null
          ? null
          : IdNameModel.fromJson(
              json['defaultExpenseCategory'] as Map<String, dynamic>),
      defaultIncomeCategory: json['defaultIncomeCategory'] == null
          ? null
          : IdNameModel.fromJson(
              json['defaultIncomeCategory'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'group': instance.group,
      'notes': instance.notes,
      'descriptionEnable': instance.descriptionEnable,
      'timeEnable': instance.timeEnable,
      'imageEnable': instance.imageEnable,
      'defaultExpenseAccount': instance.defaultExpenseAccount,
      'defaultIncomeAccount': instance.defaultIncomeAccount,
      'defaultTransferFromAccount': instance.defaultTransferFromAccount,
      'defaultTransferToAccount': instance.defaultTransferToAccount,
      'defaultExpenseCategory': instance.defaultExpenseCategory,
      'defaultIncomeCategory': instance.defaultIncomeCategory,
    };
