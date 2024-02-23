import 'package:equatable/equatable.dart';

final class ExpirationDate extends Equatable {
  static final infinite = ExpirationDate(DateTime(-1));

  const ExpirationDate(this.value);

  final DateTime value;

  bool get isInfinite => this == infinite;
  bool get isExpired => this != infinite && value.isBefore(DateTime.now());

  @override
  List<Object?> get props => [];
}
