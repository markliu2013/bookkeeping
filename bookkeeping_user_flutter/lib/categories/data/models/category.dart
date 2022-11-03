import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '/categories/categories.dart';

part 'category.g.dart';

@JsonSerializable()
class Category extends Equatable {

  final int id;
  final String name;
  final String? notes;
  final bool enable;
  final int? parentId;
  final String? parentName;

  Category({
    required this.id,
    required this.name,
    this.notes,
    required this.enable,
    this.parentId,
    this.parentName
  });

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  factory Category.fromTree(CategoryTree categoryTree) => Category(
      id: categoryTree.id,
      name: categoryTree.name,
      notes: categoryTree.notes,
      enable: categoryTree.enable,
      parentId: categoryTree.parentId,
      parentName: categoryTree.parentName
  );

  @override
  List<Object> get props => [id];

}