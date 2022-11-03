import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'book_query_request.g.dart';

@JsonSerializable()
class BookQueryRequest extends Equatable {

  final int page;
  final int size;

  const BookQueryRequest({
    this.page = 1,
    this.size = 10,
  });

  BookQueryRequest copyWith({
    int? page,
    int? size,
  }) {
    return BookQueryRequest(
      page: page ?? this.page,
      size: size ?? this.size,
    );
  }

  factory BookQueryRequest.fromJson(Map<String, dynamic> json) => _$BookQueryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BookQueryRequestToJson(this);

  @override
  List<Object?> get props => [page];

}