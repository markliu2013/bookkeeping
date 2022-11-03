import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payee.g.dart';

@JsonSerializable()
class Payee extends Equatable {

  final int id;
  final String name;
  final bool enable;
  final bool expenseable;
  final bool incomeable;
  final String? notes;

  Payee({
    required this.id,
    required this.name,
    required this.enable,
    required this.expenseable,
    required this.incomeable,
    this.notes
  });

  factory Payee.fromJson(Map<String, dynamic> json) => _$PayeeFromJson(json);

  Map<String, dynamic> toJson() => _$PayeeToJson(this);

  @override
  List<Object> get props => [id];

}