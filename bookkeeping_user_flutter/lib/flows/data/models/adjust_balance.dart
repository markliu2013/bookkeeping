import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import '/commons/commons.dart';

part 'adjust_balance.g.dart';

@JsonSerializable()
class AdjustBalance extends Equatable {

  final int id;
  final num amount;
  final IdNameModel? account;
  final String accountName;
  final int createTime;
  final String? description;
  final String? notes;
  final int status;

  AdjustBalance({
    required this.id,
    required this.amount,
    required this.account,
    required this.accountName,
    required this.createTime,
    this.description,
    this.notes,
    required this.status
  });

  factory AdjustBalance.fromJson(Map<String, dynamic> json) => _$AdjustBalanceFromJson(json);

  Map<String, dynamic> toJson() => _$AdjustBalanceToJson(this);

  @override
  List<Object> get props => [id];

}