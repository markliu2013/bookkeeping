import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'category_form_request.g.dart';

@JsonSerializable()
class CategoryFormRequest extends Equatable {

  final String? name;
  final String? notes;
  final String? parentId;

  const CategoryFormRequest({
    this.name,
    this.notes,
    this.parentId,
  });

  Map<String, dynamic> toJson() => _$CategoryFormRequestToJson(this);

  CategoryFormRequest copyWith({
    String? name,
    String? notes,
    String? parentId
  }) {
    return CategoryFormRequest(
      name: name ?? this.name,
      notes: notes ?? this.notes,
      parentId: parentId ?? this.parentId
    );
  }

  @override
  List<Object?> get props => [name, notes, parentId];

}