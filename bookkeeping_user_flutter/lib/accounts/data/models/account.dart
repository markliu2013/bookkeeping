import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable()
class Account extends Equatable {

  final int id;
  final int type;
  final String typeName;
  final String name;
  final String? no;
  final double balance;
  final String currencyCode;
  final double? convertedBalance;
  final bool enable;
  final bool include;
  final bool expenseable;
  final bool incomeable;
  final bool transferFromAble;
  final bool transferToAble;
  final double initialBalance;
  final String? notes;

  //credit
  final double? limit;
  final int? billDay;
  final double? remainLimit;
  final double? apr;
  final int? asOfDate;

  Account({
    required this.id,
    required this.type,
    required this.typeName,
    required this.name,
    required this.balance,
    required this.currencyCode,
    required this.convertedBalance,
    required this.enable,
    required this.include,
    required this.expenseable,
    required this.incomeable,
    required this.transferFromAble,
    required this.transferToAble,
    required this.initialBalance,
    this.no,
    this.notes,
    this.limit,
    this.billDay,
    this.remainLimit,
    this.apr,
    this.asOfDate
  });

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);

  @override
  List<Object> get props => [id];

}