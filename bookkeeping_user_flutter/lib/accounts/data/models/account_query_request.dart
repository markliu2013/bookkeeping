import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'account_query_request.g.dart';

@JsonSerializable()
class AccountQueryRequest extends Equatable {

  final int type;
  final int page;
  final int size;
  final String sort;

  const AccountQueryRequest({
    this.type = 1,
    this.page = 1,
    this.size = 10,
    this.sort = ''
  });

  factory AccountQueryRequest.fromJson(Map<String, dynamic> json) => _$AccountQueryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AccountQueryRequestToJson(this);

  @override
  List<Object?> get props => [type, page, sort];

  AccountQueryRequest copyWith({
    int? type,
    int? page,
    int? size,
    String? sort,
  }) {
    return AccountQueryRequest(
      type: type ?? this.type,
      page: page ?? this.page,
      size: size ?? this.size,
      sort: sort ?? this.sort,
    );
  }

}