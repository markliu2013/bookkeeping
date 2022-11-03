import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '/tags/data/models/tag_tree.dart';

part 'tag.g.dart';

@JsonSerializable()
class Tag extends Equatable {

  final int id;
  final String name;
  final String? notes;
  final bool enable;
  final int? parentId;
  final String? parentName;
  final bool expenseable;
  final bool incomeable;
  final bool transferable;

  Tag({
    required this.id,
    required this.name,
    required this.enable,
    this.parentId,
    this.parentName,
    required this.expenseable,
    required this.incomeable,
    required this.transferable,
    this.notes
  });

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);

  factory Tag.fromTree(TagTree tagTree) => Tag(
      id: tagTree.id,
      name: tagTree.name,
      notes: tagTree.notes,
      enable: tagTree.enable,
      parentId: tagTree.parentId,
      parentName: tagTree.parentName,
      expenseable: tagTree.expenseable,
      incomeable: tagTree.incomeable,
      transferable: tagTree.transferable
  );

  @override
  List<Object> get props => [id];

}