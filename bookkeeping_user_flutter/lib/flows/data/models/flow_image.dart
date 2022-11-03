import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'flow_image.g.dart';

@JsonSerializable()
class FlowImage extends Equatable {

  final int id;
  final String url;
  final int userId;
  final int? dealId;

  FlowImage({
    required this.id,
    required this.url,
    required this.userId,
    this.dealId,
  });

  factory FlowImage.fromJson(Map<String, dynamic> json) => _$FlowImageFromJson(json);

  Map<String, dynamic> toJson() => _$FlowImageToJson(this);

  @override
  List<Object> get props => [id];

}