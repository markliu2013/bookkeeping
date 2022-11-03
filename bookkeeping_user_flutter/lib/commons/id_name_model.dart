import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'id_name_model.g.dart';

@JsonSerializable()
class IdNameModel extends Equatable {

  final int id;
  final String name;

  const IdNameModel({
    required this.id,
    required this.name,
  });

  factory IdNameModel.fromJson(Map<String, dynamic> json) => _$IdNameModelFromJson(json);

  Map<String, dynamic> toJson() => _$IdNameModelToJson(this);

  @override
  List<Object> get props => [id];

}