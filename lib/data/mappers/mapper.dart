import 'package:test/domain/entities/enrolled_course.dart';
import 'package:test/domain/entities/student.dart';
import 'package:test/domain/value_objects/email.dart';
import 'package:test/domain/value_objects/expiration_date.dart';
import 'package:test/domain/value_objects/name.dart';
import 'package:test/domain/value_objects/student_status.dart';

abstract interface class EntityMapper<E> {
  Map toMap(E entity);
  E fromMap(Map data);
}

abstract interface class ModelMapper<M> {
  dynamic toMap(M model);
  M fromMap(dynamic data);
}

final class StudentMapper implements EntityMapper<Student> {
  @override
  Student fromMap(Map data) {
    return Student(
      id: data['id'],
      name: Name(data['name']),
      email: Email(data['email']),
      status: _studentStatusFromMap(data['status']),
      enrolledCourses: _enrolledCoursesFromMap(data['enrolled_courses']),
    );
  }

  @override
  Map toMap(Student student) {
    return {
      'id': student.id,
      'name': student.name.value,
      'email': student.email.value,
      'status': _studentStatusToMap(student.status),
      'enrolled_courses': _enrolledCoursesToMap(
        student.enrolledCourses.toList() as List<EnrolledCourse>,
      ),
    };
  }

  List<EnrolledCourse> _enrolledCoursesFromMap(List<Map> data) {
    final enrolledCourseMapper = EnrolledCourseMapper();
    return data.map(enrolledCourseMapper.fromMap).toList();
  }

  List<Map> _enrolledCoursesToMap(List<EnrolledCourse> courses) {
    final enrolledCourseMapper = EnrolledCourseMapper();
    return courses.map(enrolledCourseMapper.toMap).toList();
  }

  StudentStatus _studentStatusFromMap(Map data) {
    return StudentStatus(
      expirationDate: ExpirationDateMapper().fromMap(data['expirationDate']),
      type: StudentAccountType.values[data['type']],
    );
  }

  Map _studentStatusToMap(StudentStatus status) {
    return {
      'type': status.type.index,
      'expirationDate': ExpirationDateMapper().toMap(status.expirationDate),
    };
  }
}

final class EnrolledCourseMapper implements EntityMapper<EnrolledCourse> {
  @override
  EnrolledCourse fromMap(Map data) {
    return EnrolledCourse(
      id: data['id'],
      courseId: data['course_id'],
      studentId: data['student_id'],
      expirationDate: ExpirationDateMapper().fromMap(data['expiration_date']),
      price: data['price'],
    );
  }

  @override
  Map toMap(EnrolledCourse entity) {
    return {
      'id': entity.id,
      'course_id': entity.courseId,
      'student_id': entity.studentId,
      'price': entity.price,
      'expiration_date': ExpirationDateMapper().toMap(entity.expirationDate),
    };
  }
}

final class ExpirationDateMapper implements ModelMapper<ExpirationDate> {
  @override
  ExpirationDate fromMap(dynamic data) {
    return ExpirationDate(
      DateTime.fromMillisecondsSinceEpoch(data),
    );
  }

  @override
  int toMap(ExpirationDate model) {
    return model.value.millisecondsSinceEpoch;
  }
}
