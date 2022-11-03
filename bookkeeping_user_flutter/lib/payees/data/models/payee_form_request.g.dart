// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payee_form_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayeeFormRequest _$PayeeFormRequestFromJson(Map<String, dynamic> json) =>
    PayeeFormRequest(
      name: json['name'] as String?,
      expenseable: json['expenseable'] as bool?,
      incomeable: json['incomeable'] as bool?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$PayeeFormRequestToJson(PayeeFormRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'expenseable': instance.expenseable,
      'incomeable': instance.incomeable,
      'notes': instance.notes,
    };
