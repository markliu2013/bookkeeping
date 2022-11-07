import 'package:formz/formz.dart';

enum ApiUrlValidationError { empty }

class ApiUrl extends FormzInput<String, ApiUrlValidationError> {
  const ApiUrl.pure() : super.pure('');
  const ApiUrl.dirty([String value = '']) : super.dirty(value);

  @override
  ApiUrlValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : ApiUrlValidationError.empty;
  }

}
