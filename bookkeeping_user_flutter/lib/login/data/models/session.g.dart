// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      userSessionVO:
          User.fromJson(json['userSessionVO'] as Map<String, dynamic>),
      defaultBook: Book.fromJson(json['defaultBook'] as Map<String, dynamic>),
      defaultGroup:
          Group.fromJson(json['defaultGroup'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'userSessionVO': instance.userSessionVO,
      'defaultBook': instance.defaultBook,
      'defaultGroup': instance.defaultGroup,
    };
