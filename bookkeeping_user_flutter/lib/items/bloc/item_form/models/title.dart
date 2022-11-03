import 'package:formz/formz.dart';

enum TitleValidationError { empty }

class Title extends FormzInput<String, TitleValidationError> {
  const Title.pure() : super.pure('');
  const Title.dirty([String value = '']) : super.dirty(value);

  @override
  TitleValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : TitleValidationError.empty;
  }

}
