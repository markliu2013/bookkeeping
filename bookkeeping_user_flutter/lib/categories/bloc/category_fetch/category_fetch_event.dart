part of 'category_fetch_bloc.dart';

@immutable
class CategoryFetchEvent extends Equatable {
  const CategoryFetchEvent();
  @override
  List<Object> get props => [];
}

class CategoryFetched extends CategoryFetchEvent {}

class CategoryLoadDefault extends CategoryFetchEvent {
  final Category category;
  const CategoryLoadDefault({
    required this.category,
  });
  List<Object> get props => [category];
}
