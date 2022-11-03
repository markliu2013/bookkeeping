import 'package:json_annotation/json_annotation.dart';

part 'deal_add_request.g.dart';

@JsonSerializable()
class DealAddRequest {

  final String? description;
  final int? createTime;
  final String? accountId;
  final List<CategoryIdAmountRequest>? categories;
  final String? payeeId;
  final List<String>? tags;
  final bool? confirmed;
  final String? notes;

  const DealAddRequest({
    this.description,
    this.createTime,
    this.accountId,
    this.categories,
    this.payeeId,
    this.tags,
    this.confirmed,
    this.notes
  });

  DealAddRequest copyWith({
    String? description,
    int? createTime,
    String? accountId,
    String? payeeId,
    List<CategoryIdAmountRequest>? categories,
    List<String>? tags,
    bool? confirmed = true,
    String? notes
  }) {
    return DealAddRequest(
      description: description ?? this.description,
      createTime: createTime ?? this.createTime,
      accountId: accountId ?? this.accountId,
      payeeId: payeeId ?? this.payeeId,
      categories: categories ?? this.categories,
      tags: tags ?? this.tags,
      confirmed: confirmed ?? this.confirmed,
      notes: notes ?? this.notes
    );
  }

  //factory ExpenseAddRequest.fromJson(Map<String, dynamic> json) => _$ExpenseAddRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DealAddRequestToJson(this);

  List<String> get categoryIds {
    if (categories != null) {
      return categories!.map((i) {return i.categoryId;}).toList();
    } else {
      return [];
    }
  }

}

@JsonSerializable()
class CategoryIdAmountRequest {

  String categoryId;
  String categoryName;
  num amount;
  num? convertedAmount;

  CategoryIdAmountRequest({
    required this.categoryId,
    required this.categoryName,
    required this.amount,
    this.convertedAmount,
  });

  factory CategoryIdAmountRequest.fromJson(Map<String, dynamic> json) => _$CategoryIdAmountRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryIdAmountRequestToJson(this);

}
