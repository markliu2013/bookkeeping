part of 'category_form_bloc.dart';

@immutable
class CategoryFormState extends Equatable {

  final FormzStatus status;
  final CategoryFormRequest request;

  const CategoryFormState({
    this.status = FormzStatus.pure,
    this.request = const CategoryFormRequest(),
  });

  CategoryFormState copyWith({
    FormzStatus? status,
    CategoryFormRequest? request,
  }) {
    return CategoryFormState(
      status: status ?? this.status,
      request: request ?? this.request,
    );
  }

  @override
  List<Object> get props => [status, request];

}
