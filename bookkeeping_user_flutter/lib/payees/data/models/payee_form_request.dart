import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'payee_form_request.g.dart';

@JsonSerializable()
class PayeeFormRequest extends Equatable {

  final String? name;
  final bool? expenseable;
  final bool? incomeable;
  final String? notes;

  const PayeeFormRequest({
    this.name,
    this.expenseable,
    this.incomeable,
    this.notes,
  });

  PayeeFormRequest copyWith({
    String? name,
    bool? expenseable,
    bool? incomeable,
    String? notes,
  }) {
    return PayeeFormRequest(
      name: name ?? this.name,
      expenseable: expenseable ?? this.expenseable,
      incomeable: incomeable ?? this.incomeable,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() => _$PayeeFormRequestToJson(this);

  @override
  List<Object?> get props => [name, expenseable, incomeable, notes];

}