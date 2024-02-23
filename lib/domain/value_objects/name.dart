import 'package:equatable/equatable.dart';
import 'package:test/core/error.dart';
import 'package:test/core/result.dart';

final class Name extends Equatable {
  static Result<Name, ValidationError> create(String value) {
    if (value.isEmpty) return Result.error(ValidationError('Empty Name'));
    if (value.length > 56) return Result.error(ValidationError('too long name'));

    return Result.value(Name(value));
  }

  const Name(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}
