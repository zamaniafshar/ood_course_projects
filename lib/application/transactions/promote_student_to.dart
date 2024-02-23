import 'package:test/core/error.dart';
import 'package:test/core/result.dart';
import 'package:test/data/repositories/student_repository.dart';
import 'package:test/domain/value_objects/student_status.dart';

final class PromoteStudentToTransaction {
  PromoteStudentToTransaction(this._studentRepository);

  final StudentRepository _studentRepository;

  Future<Result<EmptyValue, ApplicationError>> call(String id, PromoteStudentToType type) async {
    final student = await _studentRepository.read(id);
    if (student == null) return Result.error(ApplicationError('Student not found'));

    final status = switch (type) {
      PromoteStudentToType.silver => StudentStatus.silver(),
      PromoteStudentToType.gold => StudentStatus.gold(),
    };

    final result = student.promoteTo(status);
    if (result.hasValue) {
      await _studentRepository.update(student);
    }

    return result;
  }
}

enum PromoteStudentToType { silver, gold }
