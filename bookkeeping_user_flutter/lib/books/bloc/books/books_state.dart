part of 'books_bloc.dart';

@immutable
class BooksState extends Equatable {

  final LoadDataStatus status;
  final List<Book> books;
  final BookQueryRequest request;
  final LoadDataStatus loadMoreStatus;
  final LoadDataStatus deleteStatus;
  final LoadDataStatus defaultStatus;

  const BooksState({
    this.status = LoadDataStatus.initial,
    this.books = const <Book>[],
    this.request = const BookQueryRequest(),
    this.loadMoreStatus = LoadDataStatus.initial,
    this.deleteStatus = LoadDataStatus.initial,
    this.defaultStatus = LoadDataStatus.initial,
  });

  BooksState copyWith({
    LoadDataStatus? status,
    List<Book>? books,
    BookQueryRequest? request,
    LoadDataStatus? loadMoreStatus,
    LoadDataStatus? deleteStatus,
    LoadDataStatus? defaultStatus,
  }) {
    return BooksState(
      status: status ?? this.status,
      books: books ?? this.books,
      request: request ?? this.request,
      loadMoreStatus: loadMoreStatus ?? this.loadMoreStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      defaultStatus: defaultStatus ?? this.defaultStatus
    );
  }

  @override
  List<Object?> get props => [status, books, request, loadMoreStatus, deleteStatus, defaultStatus];

}
