import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '/login/login.dart';
import '/books/books.dart';
import '/commons/commons.dart';
import '/flows/flows.dart';
import '/categories/categories.dart';
import '/payees/payees.dart';
import '/tags/tags.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {

  final BookRepository bookRepository;
  final AuthBloc authBloc;
  final FlowsBloc flowsBloc;
  final ExpenseCategorySelectBloc expenseCategorySelectBloc;
  final IncomeCategorySelectBloc incomeCategorySelectBloc;
  final TagExpenseableBloc tagExpenseableBloc;
  final TagIncomeableBloc tagIncomeableBloc;
  final TagTransferableBloc tagTransferableBloc;
  final TagEnableBloc tagEnableBloc;
  final PayeeExpenseableBloc payeeExpenseableBloc;
  final PayeeIncomeableBloc payeeIncomeableBloc;
  final PayeeEnableBloc payeeEnableBloc;

  BooksBloc({
    required this.bookRepository,
    required this.authBloc,
    required this.flowsBloc,
    required this.expenseCategorySelectBloc,
    required this.incomeCategorySelectBloc,
    required this.tagExpenseableBloc,
    required this.tagIncomeableBloc,
    required this.tagTransferableBloc,
    required this.tagEnableBloc,
    required this.payeeExpenseableBloc,
    required this.payeeIncomeableBloc,
    required this.payeeEnableBloc,
  }) : super(BooksState()) {
    on<BooksRefreshed>(_onRefreshed);
    on<BooksLoadMore>(_onLoadMore);
    on<BookSetDefault>(_onDefault);
  }

  void _onRefreshed(_, Emitter<BooksState> emit) async {
    try {
      emit(state.copyWith(
        status: LoadDataStatus.progress,
        request: state.request.copyWith(page: 1),
      ));
      final books = await bookRepository.query(state.request);
      emit(state.copyWith(
        status: LoadDataStatus.success,
        books: books,
        request: state.request.copyWith(page: state.request.page + 1),
      ));
    } catch (_) {
      emit(state.copyWith(status: LoadDataStatus.failure));
    }
  }

  void _onLoadMore(_, Emitter<BooksState> emit) async {
    try {
      emit(state.copyWith(loadMoreStatus: LoadDataStatus.progress));
      final books = await bookRepository.query(state.request);
      if (books.isNotEmpty) {
        emit(state.copyWith(
          request: state.request.copyWith(page: state.request.page + 1),
          books: List.of(state.books)..addAll(books),
          loadMoreStatus: LoadDataStatus.success,
        ));
      } else {
        emit(state.copyWith(loadMoreStatus: LoadDataStatus.empty));
      }
    } catch (_) {
      emit(state.copyWith(loadMoreStatus: LoadDataStatus.failure));
    }
  }

  void _onDefault(BookSetDefault event, Emitter<BooksState> emit) async {
    try {
      emit(state.copyWith(defaultStatus: LoadDataStatus.progress));
      final result = await bookRepository.setDefault(event.book.id.toString());
      if (result) {
        emit(state.copyWith(defaultStatus: LoadDataStatus.success));
        authBloc.add(DefaultBookChanged(event.book));
        flowsBloc.add(FlowsRefreshed());
        expenseCategorySelectBloc.add(ExpenseCategorySelectLoaded());
        incomeCategorySelectBloc.add(IncomeCategorySelectLoaded());
        tagExpenseableBloc.add(TagExpenseableLoaded());
        tagIncomeableBloc.add(TagIncomeableLoaded());
        tagTransferableBloc.add(TagTransferableLoaded());
        tagEnableBloc.add(TagEnableLoaded());
        payeeExpenseableBloc.add(PayeeExpenseableLoaded());
        payeeIncomeableBloc.add(PayeeIncomeableLoaded());
        payeeEnableBloc.add(PayeeEnableLoaded());
      } else {
        emit(state.copyWith(defaultStatus: LoadDataStatus.failure));
      }
    } catch (_) {
      emit(state.copyWith(defaultStatus: LoadDataStatus.failure));
    }
  }

}
