import 'package:test/core/error.dart';
import 'package:test/core/result.dart';
import 'package:test/data/repositories/course_repository.dart';
import 'package:test/data/repositories/student_repository.dart';

final class EnrollStudentInCourseTransaction {
  EnrollStudentInCourseTransaction({
    required StudentRepository studentRepository,
    required CourseRepository courseRepository,
  })  : _studentRepository = studentRepository,
        _courseRepository = courseRepository;

  final StudentRepository _studentRepository;
  final CourseRepository _courseRepository;

  Future<Result<EmptyValue, ApplicationError>> call(String id, String courseId) async {
    final student = await _studentRepository.read(id);
    if (student == null) return Result.error(ApplicationError('Student not found'));

    final course = await _courseRepository.read(courseId);
    if (course == null) return Result.error(ApplicationError('Course not found'));

    student.enrollInCourse(course);
    await _studentRepository.update(student);

    return Result.emptyValue();
  }
}
