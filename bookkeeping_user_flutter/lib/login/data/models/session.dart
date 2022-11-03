import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '/books/books.dart';
import '/groups/groups.dart';
import 'user.dart';

part 'session.g.dart';

@JsonSerializable()
class Session extends Equatable {

  final User userSessionVO;
  final Book defaultBook;
  final Group defaultGroup;

  const Session({
    required this.userSessionVO,
    required this.defaultBook,
    required this.defaultGroup
  });

  Session copyWith({
    User? userSessionVO,
    Book? defaultBook,
    Group? defaultGroup
  }) {
    return Session(
      userSessionVO: userSessionVO ?? this.userSessionVO,
      defaultBook: defaultBook ?? this.defaultBook,
      defaultGroup: defaultGroup ?? this.defaultGroup
    );
  }

  factory Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);

  @override
  List<Object> get props => [userSessionVO, defaultBook, defaultGroup];

}