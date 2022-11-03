import 'package:json_annotation/json_annotation.dart';

part 'transfer_add_request.g.dart';

@JsonSerializable()
class TransferAddRequest {

  final String? description;
  final int? createTime;
  final String? fromId;
  final String? toId;
  final num? amount;
  final num? convertedAmount;
  final List<String>? tags;
  final bool? confirmed;
  final String? notes;

  const TransferAddRequest({
    this.description,
    this.createTime,
    this.fromId,
    this.toId,
    this.amount,
    this.convertedAmount,
    this.tags,
    this.confirmed,
    this.notes
  });

  TransferAddRequest copyWith({
    String? description,
    int? createTime,
    String? fromId,
    String? toId,
    num? amount,
    num? convertedAmount,
    List<String>? tags,
    bool? confirmed = true,
    String? notes
  }) {
    return TransferAddRequest(
      description: description ?? this.description,
      createTime: createTime ?? this.createTime,
      fromId: fromId ?? this.fromId,
      toId: toId ?? this.toId,
      amount: amount ?? this.amount,
      convertedAmount: convertedAmount ?? this.convertedAmount,
      tags: tags ?? this.tags,
      confirmed: confirmed ?? this.confirmed,
      notes: notes ?? this.notes
    );
  }

  Map<String, dynamic> toJson() => _$TransferAddRequestToJson(this);

}
