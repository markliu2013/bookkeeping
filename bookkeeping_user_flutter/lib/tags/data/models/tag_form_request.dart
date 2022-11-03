import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'tag_form_request.g.dart';

@JsonSerializable()
class TagFormRequest extends Equatable {

  final String? name;
  final String? notes;
  final String? parentId;
  final bool? expenseable;
  final bool? incomeable;
  final bool? transferable;

  const TagFormRequest({
    this.name,
    this.notes,
    this.parentId,
    this.expenseable,
    this.incomeable,
    this.transferable
  });

  Map<String, dynamic> toJson() => _$TagFormRequestToJson(this);

  TagFormRequest copyWith({
    String? name,
    String? notes,
    String? parentId,
    bool? expenseable,
    bool? incomeable,
    bool? transferable,
  }) {
    return TagFormRequest(
      name: name ?? this.name,
      notes: notes ?? this.notes,
      parentId: parentId ?? this.parentId,
      expenseable: expenseable ?? this.expenseable,
      incomeable: incomeable ?? this.incomeable,
      transferable: transferable ?? this.transferable,
    );
  }

  @override
  List<Object?> get props => [name, notes, parentId, expenseable, incomeable, transferable];

}