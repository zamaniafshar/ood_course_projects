import 'package:test/data/utils/db_helper.dart';
import 'package:test/domain/entities/course.dart';

final class CourseRepository extends DatabaseHelper<Course> {
  CourseRepository(super.box, super._mapper);
}
