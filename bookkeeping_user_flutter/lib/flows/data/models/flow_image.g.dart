// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flow_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlowImage _$FlowImageFromJson(Map<String, dynamic> json) => FlowImage(
      id: json['id'] as int,
      url: json['url'] as String,
      userId: json['userId'] as int,
      dealId: json['dealId'] as int?,
    );

Map<String, dynamic> _$FlowImageToJson(FlowImage instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'userId': instance.userId,
      'dealId': instance.dealId,
    };
