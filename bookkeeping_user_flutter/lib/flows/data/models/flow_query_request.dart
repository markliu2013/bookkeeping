import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'flow_query_request.g.dart';

@JsonSerializable()
class FlowQueryRequest extends Equatable {

  final List<String>? payees;
  final String? type;//1-支出 2-收入 3-转账 4-余额调整
  final String? accountId;
  final String? status;//
  final List<String>? tags;
  final List<String>? categories;
  final int? minTime;
  final int? maxTime;
  final int page;
  final int size;
  final String sort;

  const FlowQueryRequest({
    this.payees,
    this.type,
    this.accountId,
    this.status,
    this.tags,
    this.categories,
    this.minTime,
    this.maxTime,
    this.page = 1,
    this.size = 10,
    this.sort = 'createTime,desc'
  });

  factory FlowQueryRequest.fromJson(Map<String, dynamic> json) => _$FlowQueryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FlowQueryRequestToJson(this);

  @override
  List<Object?> get props => [payees, type, accountId, status, tags, categories, minTime, maxTime, page, sort];

  FlowQueryRequest copyWith({
    List<String>? payees,
    String? type,
    String? accountId,
    String? status,
    List<String>? tags,
    List<String>? categories,
    int? minTime,
    int? maxTime,
    int? page,
    int? size,
    String? sort,
  }) {
    return FlowQueryRequest(
      payees: payees ?? this.payees,
      type: type ?? this.type,
      accountId: accountId ?? this.accountId,
      status: status ?? this.status,
      tags: tags ?? this.tags,
      categories: categories ?? this.categories,
      minTime: minTime ?? this.minTime,
      maxTime: maxTime ?? this.maxTime,
      page: page ?? this.page,
      size: size ?? this.size,
      sort: sort ?? this.sort,
    );
  }

}