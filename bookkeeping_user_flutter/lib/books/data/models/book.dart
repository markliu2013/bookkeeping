import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '/commons/commons.dart';

part 'book.g.dart';

@JsonSerializable()
class Book extends Equatable {

  final int id;
  final String name;
  final IdNameModel group;
  final String? notes;
  final bool descriptionEnable;
  final bool timeEnable;
  final bool imageEnable;
  final IdNameModel? defaultExpenseAccount;
  final IdNameModel? defaultIncomeAccount;
  final IdNameModel? defaultTransferFromAccount;
  final IdNameModel? defaultTransferToAccount;
  final IdNameModel? defaultExpenseCategory;
  final IdNameModel? defaultIncomeCategory;

  const Book({
    required this.id,
    required this.name,
    required this.group,
    this.notes,
    required this.descriptionEnable,
    required this.timeEnable,
    required this.imageEnable,
    this.defaultExpenseAccount,
    this.defaultIncomeAccount,
    this.defaultTransferFromAccount,
    this.defaultTransferToAccount,
    this.defaultExpenseCategory,
    this.defaultIncomeCategory,
  });

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);

  @override
  List<Object> get props => [id];

}