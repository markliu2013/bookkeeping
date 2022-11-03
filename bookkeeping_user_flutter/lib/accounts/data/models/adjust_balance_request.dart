import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'adjust_balance_request.g.dart';

@JsonSerializable()
class AdjustBalanceRequest extends Equatable {

  final String? description;
  final int? createTime;
  final String? balance;
  final String? convertedBalance;
  final String? notes;

  const AdjustBalanceRequest({
    this.description,
    this.createTime,
    this.balance,
    this.convertedBalance,
    this.notes,
  });

  AdjustBalanceRequest copyWith({
    String? description,
    int? createTime,
    String? balance,
    String? convertedBalance,
    String? notes,
  }) {
    return AdjustBalanceRequest(
      description: description ?? this.description,
      createTime: createTime ?? this.createTime,
      balance: balance ?? this.balance,
      convertedBalance: convertedBalance ?? this.convertedBalance,
      notes: notes ?? this.notes,
    );
  }

  factory AdjustBalanceRequest.fromJson(Map<String, dynamic> json) => _$AdjustBalanceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AdjustBalanceRequestToJson(this);

  @override
  List<Object?> get props => [description, createTime, balance, convertedBalance, notes];

}