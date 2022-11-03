part of 'book_fetch_bloc.dart';

@immutable
class BookFetchState extends Equatable {

  final LoadDataStatus status;
  final Book? book;

  const BookFetchState({
    this.status = LoadDataStatus.initial,
    this.book,
  });

  BookFetchState copyWith({
    LoadDataStatus? status,
    Book? book,
  }) {
    return BookFetchState(
      status: status ?? this.status,
      book: book ?? this.book,
    );
  }

  @override
  List<Object?> get props => [status, book];

}
