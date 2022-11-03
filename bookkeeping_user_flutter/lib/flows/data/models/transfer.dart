import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

import 'tag.dart';
import '/commons/commons.dart';

part 'transfer.g.dart';

@JsonSerializable()
class Transfer extends Equatable {

  final int id;
  final num amount;
  final num convertedAmount;
  final IdNameModel from;
  final IdNameModel to;
  final String accountName;
  final int createTime;
  final String? description;
  final String? notes;
  final int status;
  final List<Tag>? tags;

  Transfer({
    required this.id,
    required this.amount,
    required this.convertedAmount,
    required this.from,
    required this.to,
    required this.accountName,
    required this.createTime,
    this.description,
    this.notes,
    required this.status,
    this.tags,
  });

  factory Transfer.fromJson(Map<String, dynamic> json) => _$TransferFromJson(json);

  Map<String, dynamic> toJson() => _$TransferToJson(this);

  @override
  List<Object> get props => [id];

}