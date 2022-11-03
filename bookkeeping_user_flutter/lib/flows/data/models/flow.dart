import 'package:bookkeeping_user_flutter/flows/data/models/adjust_balance.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

import 'deal.dart';
import 'tag.dart';
import 'transfer.dart';
import '/commons/commons.dart';

part 'flow.g.dart';

@JsonSerializable()
class FlowModel extends Equatable {

  final int id;
  final double amount;
  final String amountFormatted;
  final double? convertedAmount;
  final bool needConvert;
  final String? toCurrencyCode;
  final String? accountName;
  final String title;
  final String subTitle;
  final int createTime;
  final String createTimeFormatted;
  final String? description;
  final String? notes;
  final String? categoryName;
  final IdNameModel? payee;
  final int status;
  final String statusName;
  final List<Tag>? tags;
  final String? tagsName;
  final int type;
  final String typeName;

  final Deal? expense;
  final Deal? income;
  final Transfer? transfer;
  final AdjustBalance? adjustBalance;

  FlowModel({
    required this.id,
    required this.amount,
    required this.amountFormatted,
    this.convertedAmount,
    required this.needConvert,
    this.toCurrencyCode,
    this.accountName,
    required this.title,
    required this.subTitle,
    required this.createTime,
    required this.createTimeFormatted,
    this.description,
    this.notes,
    this.categoryName,
    this.payee,
    required this.status,
    required this.statusName,
    this.tags,
    this.tagsName,
    required this.type,
    required this.typeName,
    this.expense,
    this.income,
    this.transfer,
    this.adjustBalance
  });

  factory FlowModel.fromJson(Map<String, dynamic> json) => _$FlowModelFromJson(json);

  Map<String, dynamic> toJson() => _$FlowModelToJson(this);

  @override
  List<Object> get props => [id];

}