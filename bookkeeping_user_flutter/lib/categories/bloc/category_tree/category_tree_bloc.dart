import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '/categories/categories.dart';
import '/commons/commons.dart';

part 'category_tree_event.dart';
part 'category_tree_state.dart';

class CategoryTreeBloc extends Bloc<CategoryTreeEvent, CategoryTreeState> {

  final CategoryRepository categoryRepository;
  final ExpenseCategorySelectBloc expenseCategorySelectBloc;
  final IncomeCategorySelectBloc incomeCategorySelectBloc;

  CategoryTreeBloc({
    required this.categoryRepository,
    required this.expenseCategorySelectBloc,
    required this.incomeCategorySelectBloc
  }) : super(CategoryTreeState()) {
    on<ExpenseCategoryTreeRefreshed>(_onExpenseCategoryRefreshed);
    on<IncomeCategoryTreeRefreshed>(_onIncomeCategoryRefreshed);
    on<CategoryItemClicked>(_onItemClicked);
    on<CategoryBackClicked>(_onBackClicked);
    on<CategoryToggled>(_onToggled);
    on<CategoryDeleted>(_onDeleted);
  }

  void _onExpenseCategoryRefreshed(_, Emitter<CategoryTreeState> emit) async {
    try {
      emit(state.copyWith(
        status: LoadDataStatus.progress,
      ));
      final categories = await categoryRepository.queryExpense();
      emit(state.copyWith(
        status: LoadDataStatus.success,
        categories: categories,
        currentCategories: categories
      ));
    } catch (_) {
      print(_);
      emit(state.copyWith(status: LoadDataStatus.failure));
    }
  }

  void _onIncomeCategoryRefreshed(_, Emitter<CategoryTreeState> emit) async {
    try {
      emit(state.copyWith(
        status: LoadDataStatus.progress,
      ));
      final categories = await categoryRepository.queryIncome();
      emit(state.copyWith(
          status: LoadDataStatus.success,
          categories: categories,
          currentCategories: categories
      ));
    } catch (_) {
      print(_);
      emit(state.copyWith(status: LoadDataStatus.failure));
    }
  }

  void _onItemClicked(CategoryItemClicked event, Emitter<CategoryTreeState> emit) async {
    List<List<CategoryTree>> newHistory = List.from(state.history);
    newHistory.add(state.currentCategories);
    emit(state.copyWith(
      currentLevel: state.currentLevel + 1,
      currentCategories: event.categoryTree.children,
      history: newHistory,
    ));
  }

  void _onBackClicked(CategoryBackClicked event, Emitter<CategoryTreeState> emit) async {
    emit(state.copyWith(
      currentLevel: state.currentLevel - 1,
      currentCategories: state.history.last
    ));
  }

  void _onToggled(CategoryToggled event, Emitter<CategoryTreeState> emit) async {
    try {
      emit(state.copyWith(toggleStatus: LoadDataStatus.progress));
      final result = await categoryRepository.toggle(event.id);
      if (result) {
        emit(state.copyWith(toggleStatus: LoadDataStatus.success));
        expenseCategorySelectBloc.add(ExpenseCategorySelectLoaded());
        incomeCategorySelectBloc.add(IncomeCategorySelectLoaded());
      } else {
        emit(state.copyWith(toggleStatus: LoadDataStatus.failure));
      }
    } catch (_) {
      emit(state.copyWith(toggleStatus: LoadDataStatus.failure));
    }
  }

  void _onDeleted(CategoryDeleted event, Emitter<CategoryTreeState> emit) async {
    try {
      emit(state.copyWith(deleteStatus: LoadDataStatus.progress));
      final result = await categoryRepository.delete(event.id);
      if (result) {
        emit(state.copyWith(deleteStatus: LoadDataStatus.success));
        expenseCategorySelectBloc.add(ExpenseCategorySelectLoaded());
        incomeCategorySelectBloc.add(IncomeCategorySelectLoaded());
      } else {
        emit(state.copyWith(deleteStatus: LoadDataStatus.failure));
      }
    } catch (_) {
      emit(state.copyWith(deleteStatus: LoadDataStatus.failure));
    }
  }

}
