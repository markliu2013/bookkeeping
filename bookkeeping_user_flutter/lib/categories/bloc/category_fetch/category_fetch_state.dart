part of 'category_fetch_bloc.dart';

@immutable
class CategoryFetchState extends Equatable {

  final LoadDataStatus status;
  final Category? category;

  const CategoryFetchState({
    this.status = LoadDataStatus.initial,
    this.category,
  });

  CategoryFetchState copyWith({
    LoadDataStatus? status,
    Category? category,
  }) {
    return CategoryFetchState(
      status: status ?? this.status,
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props => [status, category];

}
