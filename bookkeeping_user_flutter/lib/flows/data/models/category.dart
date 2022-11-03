import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category extends Equatable {

  final int id;
  final num amount;
  final num convertedAmount;
  final int categoryId;
  final String categoryName;

  Category({
    required this.id,
    required this.amount,
    required this.convertedAmount,
    required this.categoryId,
    required this.categoryName,
  });

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  List<Object> get props => [id];

}