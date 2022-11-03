import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

import '/commons/commons.dart';
import 'category.dart';
import 'tag.dart';

part 'deal.g.dart';

@JsonSerializable()
class Deal extends Equatable {

  final int id;
  final num amount;
  final num convertedAmount;
  final IdNameModel? account;
  final String? accountName;
  final int createTime;
  final String? description;
  final String? notes;
  final int status;
  final List<Category> categories;
  final String categoryName;
  final List<Tag>? tags;
  final IdNameModel? payee;

  Deal({
    required this.id,
    required this.amount,
    required this.convertedAmount,
    this.account,
    this.accountName,
    required this.createTime,
    this.description,
    this.notes,
    required this.status,
    required this.categories,
    required this.categoryName,
    this.tags,
    this.payee
  });

  factory Deal.fromJson(Map<String, dynamic> json) => _$DealFromJson(json);

  Map<String, dynamic> toJson() => _$DealToJson(this);

  @override
  List<Object> get props => [id];

}