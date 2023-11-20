import 'package:formz/formz.dart';
import 'package:fzregex/utils/fzregex.dart';
import 'package:fzregex/utils/pattern.dart';

/// A class for validating inputs
class InputValidator {
  ///Email validation method
  static bool email(String? str) {
    return Fzregex.hasMatch(str ?? '', FzPattern.email);
  }

  /// A method to validate name like input
  static String? nameValidator(String? str, {String? property}) {
    final nam = str!.trim();
    if (nam.isEmpty) {
      return property == null
          ? 'Enter a valid name'
          : 'Enter a valid $property';
    } else {
      return null;
    }
  }

  ///A method to validate password
  static bool password(String? str) {
    return Fzregex.hasMatch(str ?? '', FzPattern.passwordNormal1);
  }

  /// A method to validate confirm password by
  /// by checking if it matches the password
  static String? confirmPasswordValidator(
    String? password,
    String? confirmPassword,
  ) {
    if (password != confirmPassword) {
      return 'Confirm password must be the same\n as password';
    }
    return null;
  }
}

enum AddressValidationError { empty }

class Address extends FormzInput<String, AddressValidationError> {
  const Address.pure() : super.pure('');
  const Address.dirty([super.value = '']) : super.dirty();

  @override
  AddressValidationError? validator(String value) {
    if (value.isEmpty) return AddressValidationError.empty;
    return null;
  }
}

enum TextValidationError { empty }

class TextV extends FormzInput<String, TextValidationError> {
  const TextV.pure() : super.pure('');
  const TextV.dirty([super.value = '']) : super.dirty();

  @override
  TextValidationError? validator(String value) {
    if (value.isEmpty) return TextValidationError.empty;
    return null;
  }
}

enum AmountValidationError { empty }

class Amount extends FormzInput<String, AmountValidationError> {
  const Amount.pure() : super.pure('');
  const Amount.dirty([super.value = '']) : super.dirty();

  @override
  AmountValidationError? validator(String value) {
    if (value.isEmpty || value == '0.00') return AmountValidationError.empty;
    final amountString = value.replaceAll(',', '');
    final amount = double.parse(amountString);
    if (amount < 5000.0) return AmountValidationError.empty;
    return null;
  }
}

enum PhoneNumberValidationError { empty }

class PhoneNumberV extends FormzInput<String, AmountValidationError> {
  const PhoneNumberV.pure() : super.pure('');
  const PhoneNumberV.dirty([super.value = '']) : super.dirty();

  @override
  AmountValidationError? validator(String value) {
    if (value.isEmpty) return AmountValidationError.empty;
    return null;
  }
}
