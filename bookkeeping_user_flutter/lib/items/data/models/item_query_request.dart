import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_query_request.g.dart';

@JsonSerializable()
class ItemQueryRequest extends Equatable {

  final int page;
  final int size;
  final String sort;

  const ItemQueryRequest({
    this.page = 1,
    this.size = 10,
    this.sort = ''
  });

  factory ItemQueryRequest.fromJson(Map<String, dynamic> json) => _$ItemQueryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ItemQueryRequestToJson(this);

  @override
  List<Object?> get props => [page, sort];

  ItemQueryRequest copyWith({
    int? page,
    int? size,
    String? sort,
  }) {
    return ItemQueryRequest(
      page: page ?? this.page,
      size: size ?? this.size,
      sort: sort ?? this.sort,
    );
  }

}