base class ApplicationError {
  ApplicationError([this.message = '']);

  final String message;

  @override
  String toString() {
    return 'ApplicationError: $message';
  }
}

base class ValidationError implements ApplicationError {
  ValidationError([this.message = '']);

  @override
  final String message;

  @override
  String toString() {
    return 'ValidationError: $message';
  }
}
