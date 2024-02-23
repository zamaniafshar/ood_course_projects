import 'package:equatable/equatable.dart';
import 'package:test/domain/value_objects/expiration_date.dart';

final class StudentStatus extends Equatable {
  const StudentStatus({
    required this.expirationDate,
    required this.type,
  });

  StudentStatus.bronze()
      : expirationDate = ExpirationDate.infinite,
        type = StudentAccountType.bronze;

  factory StudentStatus.silver() {
    final now = DateTime.now();
    final expirationDate = now.copyWith(month: now.month + 6);

    return StudentStatus(
      expirationDate: ExpirationDate(expirationDate),
      type: StudentAccountType.silver,
    );
  }
  factory StudentStatus.gold() {
    final now = DateTime.now();
    final expirationDate = now.copyWith(year: now.year + 1);

    return StudentStatus(
      expirationDate: ExpirationDate(expirationDate),
      type: StudentAccountType.gold,
    );
  }

  final ExpirationDate expirationDate;
  final StudentAccountType type;

  bool get isBronze => type == StudentAccountType.bronze;
  bool get isSilver => type == StudentAccountType.silver && !expirationDate.isExpired;
  bool get isGold => type == StudentAccountType.gold && !expirationDate.isExpired;
  double get discountFactor => type.discountFactor;

  @override
  List<Object?> get props => [expirationDate, type];
}

enum StudentAccountType {
  bronze(0.95),
  silver(0.75),
  gold(0.50);

  const StudentAccountType(this.discountFactor);

  final double discountFactor;
}
