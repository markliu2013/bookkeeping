import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_add_request.g.dart';

@JsonSerializable()
class ItemAddRequest {

  final String title;
  final String? notes;
  final int startDate;
  final int endDate;
  final int repeatType;
  final int interval;

  const ItemAddRequest({
    required this.title,
    this.notes,
    required this.startDate,
    required this.endDate,
    required this.repeatType,
    required this.interval
  });

  ItemAddRequest copyWith({
    String? title,
    String? notes,
    int? startDate,
    int? endDate,
    int? repeatType,
    int? interval,
  }) {
    return ItemAddRequest(
      title: title ?? this.title,
      notes: notes ?? this.notes,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      repeatType: repeatType ?? this.repeatType,
      interval: interval ?? this.interval,
    );
  }

  factory ItemAddRequest.fromJson(Map<String, dynamic> json) => _$ItemAddRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ItemAddRequestToJson(this);

}