import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'x_y.g.dart';
@JsonSerializable()
class XY extends Equatable {

  final String x;
  final num y;
  final num percent;

  XY({
    required this.x,
    required this.y,
    required this.percent
  });

  factory XY.fromJson(Map<String, dynamic> json) => _$XYFromJson(json);

  Map<String, dynamic> toJson() => _$XYToJson(this);

  @override
  List<Object> get props => [x, y];

}