import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'payee_query_request.g.dart';

@JsonSerializable()
class PayeeQueryRequest extends Equatable {

  final int page;
  final int size;
  final String sort;

  const PayeeQueryRequest({
    this.page = 1,
    this.size = 15,
    this.sort = 'id,desc'
  });

  factory PayeeQueryRequest.fromJson(Map<String, dynamic> json) => _$PayeeQueryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PayeeQueryRequestToJson(this);

  PayeeQueryRequest copyWith({
    int? page,
    int? size,
    String? sort,
  }) {
    return PayeeQueryRequest(
      page: page ?? this.page,
      size: size ?? this.size,
      sort: sort ?? this.sort,
    );
  }

  @override
  List<Object?> get props => [page, sort];

}