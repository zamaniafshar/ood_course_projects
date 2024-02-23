import 'package:test/domain/entities/course.dart';
import 'package:test/domain/entities/entity.dart';
import 'package:test/domain/entities/student.dart';
import 'package:test/domain/value_objects/expiration_date.dart';

final class EnrolledCourse extends Entity {
  EnrolledCourse({
    super.id,
    required ExpirationDate expirationDate,
    required int price,
    required String studentId,
    required String courseId,
  })  : _expirationDate = expirationDate,
        _price = price,
        _studentId = studentId,
        _courseId = courseId;

  String _studentId;
  String _courseId;
  int _price;
  ExpirationDate _expirationDate;

  String get studentId => _studentId;
  String get courseId => _courseId;
  int get price => _price;
  ExpirationDate get expirationDate => _expirationDate;
}
