import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tag.g.dart';

@JsonSerializable()
class Tag extends Equatable {

  final int id;
  final double amount;
  final double convertedAmount;
  final int tagId;
  final String tagName;

  Tag({
    required this.id,
    required this.amount,
    required this.convertedAmount,
    required this.tagId,
    required this.tagName,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);

  @override
  List<Object> get props => [id];

}