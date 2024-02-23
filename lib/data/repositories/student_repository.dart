import 'package:test/data/utils/db_helper.dart';
import 'package:test/domain/entities/student.dart';

final class StudentRepository extends DatabaseHelper<Student> {
  StudentRepository(super.box, super._mapper);
}
