import 'package:equatable/equatable.dart';
import 'package:test/core/error.dart';
import 'package:test/core/result.dart';

final _emailValidationRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

final class Email extends Equatable {
  static Result<Email, ValidationError> create(String value) {
    if (!_emailValidationRegex.hasMatch(value))
      return Result.error(ValidationError('Invalid email'));

    return Result.value(Email(value));
  }

  const Email(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}
