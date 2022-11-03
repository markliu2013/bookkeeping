import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable()
class Item extends Equatable {

  final int id;
  final String title;
  final String? notes;
  final int nextDate;
  final int countDown;

  Item({
    required this.id,
    required this.title,
    this.notes,
    required this.nextDate,
    required this.countDown,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

  @override
  List<Object> get props => [id];

}