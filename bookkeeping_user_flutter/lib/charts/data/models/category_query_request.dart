import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'category_query_request.g.dart';

@JsonSerializable()
class CategoryQueryRequest extends Equatable {

  final int? minTime;
  final int? maxTime;
  final String? categoryId;

  const CategoryQueryRequest({
    this.minTime,
    this.maxTime,
    this.categoryId
  });

  factory CategoryQueryRequest.fromJson(Map<String, dynamic> json) => _$CategoryQueryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryQueryRequestToJson(this);

  @override
  List<Object?> get props => [minTime, maxTime, categoryId];

  CategoryQueryRequest copyWith({
    int? minTime,
    int? maxTime,
    String? categoryId
  }) {
    return CategoryQueryRequest(
      minTime: minTime ?? this.minTime,
      maxTime: maxTime ?? this.maxTime,
      categoryId: categoryId ?? this.categoryId
    );
  }

}