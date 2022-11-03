import 'package:bloc/bloc.dart';
import 'package:bookkeeping_user_flutter/books/books.dart';
import 'package:bookkeeping_user_flutter/books/data/models/book.dart';
import 'package:bookkeeping_user_flutter/commons/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'book_fetch_event.dart';
part 'book_fetch_state.dart';

class BookFetchBloc extends Bloc<BookFetchEvent, BookFetchState> {

  final BookRepository bookRepository;

  BookFetchBloc({
    required this.bookRepository,
  }) : super(BookFetchState()) {
    on<BookFetched>(_onFetched);
    on<BookLoadDefault>(_onDefault);
  }

  void _onDefault(BookLoadDefault event, Emitter<BookFetchState> emit) {
    emit(state.copyWith(
      status: LoadDataStatus.success,
      book: event.book
    ));
  }

  void _onFetched(_, Emitter<BookFetchState> emit) async {
    try {
      emit(state.copyWith(status: LoadDataStatus.progress));
      final book = await bookRepository.get(state.book!.id);
      emit(state.copyWith(
        status: LoadDataStatus.success,
        book: book,
      ));
    } catch (_) {
      emit(state.copyWith(status: LoadDataStatus.failure));
    }
  }

}
