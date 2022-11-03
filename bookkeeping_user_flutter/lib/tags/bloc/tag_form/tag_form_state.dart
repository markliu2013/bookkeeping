part of 'tag_form_bloc.dart';

@immutable
class TagFormState extends Equatable {

  final FormzStatus status;
  final TagFormRequest request;

  const TagFormState({
    this.status = FormzStatus.pure,
    this.request = const TagFormRequest(),
  });

  TagFormState copyWith({
    FormzStatus? status,
    TagFormRequest? request,
  }) {
    return TagFormState(
      status: status ?? this.status,
      request: request ?? this.request,
    );
  }

  @override
  List<Object> get props => [status, request];

}
