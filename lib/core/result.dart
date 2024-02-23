import 'package:test/core/error.dart';

final class Result<V, E extends ApplicationError> {
  Result.value(this._value) : _error = null;
  Result.error(this._error) : _value = null;

  static Result<EmptyValue, E> emptyValue<E extends ApplicationError>() {
    return Result.value(const EmptyValue());
  }

  final V? _value;
  final E? _error;

  bool get hasError => _error != null;
  bool get hasValue => _value != null;

  V get value => hasValue ? _value! : throw ArgumentError('Value of type ${V.runtimeType} is null');
  E get error => hasError ? _error! : throw ArgumentError('Error of type ${E.runtimeType} is null');

  B fold<B>(B Function(V value) onValue, B Function(E error) onError) {
    if (_value != null) return onValue(_value as V);
    return onError(_error as E);
  }

  static E? combineErrors<V, E extends ApplicationError>(List<Result<V, E>> results) {
    for (final result in results) {
      if (result.hasError) return result.error;
    }
    return null;
  }
}

final class EmptyValue {
  const EmptyValue();
}
