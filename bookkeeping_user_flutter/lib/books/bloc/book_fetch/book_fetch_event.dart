part of 'book_fetch_bloc.dart';

@immutable
class BookFetchEvent extends Equatable {
  const BookFetchEvent();
  @override
  List<Object> get props => [];
}

class BookFetched extends BookFetchEvent {}

class BookLoadDefault extends BookFetchEvent {
  final Book book;
  const BookLoadDefault({
    required this.book,
  });
  List<Object> get props => [book];
}