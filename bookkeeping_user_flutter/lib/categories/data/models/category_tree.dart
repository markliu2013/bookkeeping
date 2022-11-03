import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_tree.g.dart';

@JsonSerializable()
class CategoryTree extends Equatable {

  final int id;
  final String name;
  final String? notes;
  final bool enable;
  final int? parentId;
  final String? parentName;
  final List<CategoryTree>? children;

  CategoryTree({
    required this.id,
    required this.name,
    this.notes,
    required this.enable,
    this.parentId,
    this.parentName,
    this.children
  });

  factory CategoryTree.fromJson(Map<String, dynamic> json) => _$CategoryTreeFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryTreeToJson(this);

  @override
  List<Object> get props => [id];

}