import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/categories/categories.dart';

part 'expense_category_select_event.dart';
part 'expense_category_select_state.dart';

class ExpenseCategorySelectBloc extends Bloc<ExpenseCategorySelectEvent, ExpenseCategorySelectState> {

  final CategoryRepository categoryRepository;

  ExpenseCategorySelectBloc({
    required this.categoryRepository
  }) : super(ExpenseCategorySelectStateLoadInProgress()) {
    on<ExpenseCategorySelectLoaded>(_onExpenseCategorySelectLoaded);
  }

  void _onExpenseCategorySelectLoaded(_, Emitter<ExpenseCategorySelectState> emit) async {
    // 只加载一次数据
    // if (state is ExpenseCategorySelectStateLoadSuccess) return;
    try {
      emit(ExpenseCategorySelectStateLoadInProgress());
      final categories = await categoryRepository.getExpenseable();
      emit(ExpenseCategorySelectStateLoadSuccess(categories));
    } catch (_) {
      emit(ExpenseCategorySelectStateLoadFailure());
    }
  }

}