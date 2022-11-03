import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/categories/categories.dart';

part 'income_category_select_event.dart';
part 'income_category_select_state.dart';

class IncomeCategorySelectBloc extends Bloc<IncomeCategorySelectEvent, IncomeCategorySelectState> {

  final CategoryRepository categoryRepository;

  IncomeCategorySelectBloc({
    required this.categoryRepository
  }) : super(IncomeCategorySelectStateLoadInProgress()) {
    on<IncomeCategorySelectLoaded>(_onIncomeCategorySelectLoaded);
  }

  void _onIncomeCategorySelectLoaded(_, Emitter<IncomeCategorySelectState> emit) async {
    // 只加载一次数据
    // if (state is IncomeCategorySelectStateLoadSuccess) return;
    try {
      emit(IncomeCategorySelectStateLoadInProgress());
      final categories = await categoryRepository.getIncomeable();
      emit(IncomeCategorySelectStateLoadSuccess(categories));
    } catch (_) {
      emit(IncomeCategorySelectStateLoadFailure());
    }
  }

}