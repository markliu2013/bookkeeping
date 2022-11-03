part of 'books_bloc.dart';

@immutable
abstract class BooksEvent extends Equatable {
  const BooksEvent();
  @override
  List<Object> get props => [];
}

class BooksRefreshed extends BooksEvent { }

class BooksLoadMore extends BooksEvent { }

class BookSetDefault extends BooksEvent {
  final Book book;
  const BookSetDefault(this.book);
  @override
  List<Object> get props => [book];
}