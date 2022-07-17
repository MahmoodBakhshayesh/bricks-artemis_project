import 'package:artemis_utils/artemis_utils.dart';

import '../error/exception.dart';
import '../error/failures.dart';
import 'failure_handler.dart';

class Validator {
  Validator._();

  static bool validate(String value, ValidationRule rule) {
    try {
      int intVal = int.parse(value);
      return true;
    } catch (e) {
      ValidationFailure f = ValidationFailure.fromAppException(rule.exception);
      FailureHandler.handle(f);
      return false;
    }
  }

  static String? intValidator(String? v) {
    if (v!.isEmpty) return null;
    if (int.tryParse(v) != null) return null;
    return "Invalid  Number";
  }

  static String? dateValidator(String? v) {
    if (v!.length < 10) {
      return null;
    }
    // if(DateTime.tryParse(v)!=null){
    if (v.tryDateTime != null) {
      return null;
    }
    print(v.length);
    return "Invalid Date";
  }
}

enum ValidationRule {
  isInt,
  isNotEmpty,
}

extension Exp on ValidationRule {
  ValidationException get exception {
    switch (this) {
      case ValidationRule.isInt:
        return ValidationException(message: 'Invalid Entry', trace: StackTrace.fromString('Value is not a valid number'));
      case ValidationRule.isNotEmpty:
        return ValidationException(message: 'Invalid Int', trace: StackTrace.fromString('Value can not be empty'));
    }
  }
}
