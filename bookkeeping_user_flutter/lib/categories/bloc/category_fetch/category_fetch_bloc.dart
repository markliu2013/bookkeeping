import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '/categories/categories.dart';
import '/commons/commons.dart';

part 'category_fetch_event.dart';

part 'category_fetch_state.dart';

class CategoryFetchBloc extends Bloc<CategoryFetchEvent, CategoryFetchState> {

  final CategoryRepository categoryRepository;

  CategoryFetchBloc({
    required this.categoryRepository,
  }) : super(CategoryFetchState()) {
    on<CategoryFetched>(_onFetched);
    on<CategoryLoadDefault>(_onDefault);
  }

  void _onDefault(CategoryLoadDefault event, Emitter<CategoryFetchState> emit) {
    emit(state.copyWith(
      status: LoadDataStatus.success,
      category: event.category
    ));
  }

  void _onFetched(_, Emitter<CategoryFetchState> emit) async {
    try {
      emit(state.copyWith(status: LoadDataStatus.progress));
      final category = await categoryRepository.get(state.category!.id);
      emit(state.copyWith(
        status: LoadDataStatus.success,
        category: category,
      ));
    } catch (_) {
      emit(state.copyWith(status: LoadDataStatus.failure));
    }
  }

}
