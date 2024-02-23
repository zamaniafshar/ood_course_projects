import 'package:test/core/error.dart';
import 'package:test/core/result.dart';
import 'package:test/data/repositories/course_repository.dart';
import 'package:test/domain/entities/course.dart';

final class CreateCourseTransaction {
  CreateCourseTransaction(this._courseRepository);

  final CourseRepository _courseRepository;

  Future<Result<EmptyValue, ApplicationError>> call(CourseAccessTime accessTime, int price) async {
    final course = Course(
      accessTime: accessTime,
      price: price,
    );

    await _courseRepository.create(course);

    return Result.emptyValue();
  }
}
