import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable()
class Group extends Equatable {

  final int id;
  final String name;
  final String? notes;
  final String defaultCurrencyCode;

  const Group({
    required this.id,
    required this.name,
    this.notes,
    required this.defaultCurrencyCode,
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);

  @override
  List<Object> get props => [id];

}