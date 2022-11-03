// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payee _$PayeeFromJson(Map<String, dynamic> json) => Payee(
      id: json['id'] as int,
      name: json['name'] as String,
      enable: json['enable'] as bool,
      expenseable: json['expenseable'] as bool,
      incomeable: json['incomeable'] as bool,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$PayeeToJson(Payee instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'enable': instance.enable,
      'expenseable': instance.expenseable,
      'incomeable': instance.incomeable,
      'notes': instance.notes,
    };
