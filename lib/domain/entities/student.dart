import 'dart:collection';

import 'package:test/core/error.dart';
import 'package:test/core/result.dart';
import 'package:test/domain/entities/course.dart';
import 'package:test/domain/entities/enrolled_course.dart';
import 'package:test/domain/entities/entity.dart';
import 'package:test/domain/value_objects/email.dart';
import 'package:test/domain/value_objects/expiration_date.dart';
import 'package:test/domain/value_objects/name.dart';
import 'package:test/domain/value_objects/student_status.dart';

final class Student extends Entity {
  Student({
    super.id,
    required Name name,
    required Email email,
    List<EnrolledCourse> enrolledCourses = const [],
    StudentStatus? status,
  })  : _email = email,
        _name = name,
        _enrolledCourses = enrolledCourses,
        _status = status ?? StudentStatus.bronze();

  Name _name;
  Email _email;
  StudentStatus _status;
  List<EnrolledCourse> _enrolledCourses;

  UnmodifiableListView get enrolledCourses => UnmodifiableListView(_enrolledCourses);
  Name get name => _name;
  Email get email => _email;
  StudentStatus get status => _status;

  void enrollInCourse(Course course) {
    final now = DateTime.now();
    final expirationDate = course.accessTime == CourseAccessTime.oneMonth
        ? ExpirationDate(now.copyWith(month: now.month + 1))
        : ExpirationDate.infinite;
    final price = (course.price * status.discountFactor).toInt();

    final enrolledCourse = EnrolledCourse(
      expirationDate: expirationDate,
      price: price,
      studentId: id,
      courseId: course.id,
    );

    _enrolledCourses.add(enrolledCourse);
  }

  Result<EmptyValue, ApplicationError> promoteTo(StudentStatus status) {
    return switch (status.type) {
      StudentAccountType.bronze => throw ArgumentError("Student can't promote to bronze"),
      StudentAccountType.silver => _promoteToSilver(),
      StudentAccountType.gold => _promoteToGold(),
    };
  }

  Result<EmptyValue, ApplicationError> _promoteToSilver() {
    if (_status.isSilver) return Result.error(ApplicationError('Student is already silver'));
    if (_status.isGold) return Result.error(ApplicationError('Student account type is gold'));

    if (!_canPromoteToSilver()) return Result.error(ApplicationError('price is lower that 100'));

    _status = StudentStatus.silver();
    return Result.emptyValue();
  }

  Result<EmptyValue, ApplicationError> _promoteToGold() {
    if (_status.isGold) return Result.error(ApplicationError('Student is already gold'));

    if (!_canPromoteToGold()) return Result.error(ApplicationError('price is lower that 400'));

    _status = StudentStatus.gold();
    return Result.emptyValue();
  }

  bool _canPromoteToSilver() {
    final now = DateTime.now();
    final silverTimeLimit = now.copyWith(month: now.month - 6);
    int price = _enrolledCourses
        .where((e) => e.expirationDate.value.isAfter(silverTimeLimit))
        .map((e) => e.price)
        .reduce((v, e) => v + e);

    return price < 100;
  }

  bool _canPromoteToGold() {
    final now = DateTime.now();
    final goldTimeLimit = now.copyWith(year: now.year - 1);
    int price = _enrolledCourses
        .where((e) => e.expirationDate.value.isAfter(goldTimeLimit))
        .map((e) => e.price)
        .reduce((v, e) => v + e);

    return price < 400;
  }
}
