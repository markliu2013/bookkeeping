import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'account_form_request.g.dart';

@JsonSerializable()
class AccountFormRequest extends Equatable {

  final String? currencyCode;
  final String? name;
  final String? no; // 卡号
  final String? balance;
  final bool? include;
  final bool? transferFromAble;
  final bool? transferToAble;
  final bool? expenseable;
  final bool? incomeable;
  final String? notes;
  final String? limit;
  final String? billDay;
  final String? apr;

  const AccountFormRequest({
    this.currencyCode,
    this.name,
    this.no,
    this.balance,
    this.include,
    this.transferFromAble,
    this.transferToAble,
    this.expenseable,
    this.incomeable,
    this.notes,
    this.limit,
    this.billDay,
    this.apr,
  });

  Map<String, dynamic> toJson() => _$AccountFormRequestToJson(this);

  AccountFormRequest copyWith({
    String? currencyCode,
    String? name,
    String? no,
    String? balance,
    bool? include,
    bool? transferFromAble,
    bool? transferToAble,
    bool? expenseable,
    bool? incomeable,
    String? notes,
    String? limit,
    String? billDay,
    String? apr,
  }) {
    return AccountFormRequest(
      currencyCode: currencyCode ?? this.currencyCode,
      name: name ?? this.name,
      no: no ?? this.no,
      balance: balance ?? this.balance,
      include: include ?? this.include,
      transferFromAble: transferFromAble ?? this.transferFromAble,
      transferToAble: transferToAble ?? this.transferToAble,
      expenseable: expenseable ?? this.expenseable,
      incomeable: incomeable ?? this.incomeable,
      notes: notes ?? this.notes,
      limit: limit ?? this.limit,
      billDay: billDay ?? this.billDay,
      apr: apr ?? this.apr,
    );
  }

  @override
  List<Object?> get props => [currencyCode, name, no, balance, expenseable, incomeable, transferFromAble, transferToAble, include, notes, limit, billDay, apr];

}