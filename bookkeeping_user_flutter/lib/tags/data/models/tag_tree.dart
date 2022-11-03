import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tag_tree.g.dart';

@JsonSerializable()
class TagTree extends Equatable {

  final int id;
  final String name;
  final String? notes;
  final bool enable;
  final int? parentId;
  final String? parentName;
  final List<TagTree>? children;
  final bool expenseable;
  final bool incomeable;
  final bool transferable;

  TagTree({
    required this.id,
    required this.name,
    this.notes,
    required this.enable,
    this.parentId,
    this.parentName,
    this.children,
    required this.expenseable,
    required this.incomeable,
    required this.transferable,
  });

  factory TagTree.fromJson(Map<String, dynamic> json) => _$TagTreeFromJson(json);

  Map<String, dynamic> toJson() => _$TagTreeToJson(this);

  @override
  List<Object> get props => [id];

}