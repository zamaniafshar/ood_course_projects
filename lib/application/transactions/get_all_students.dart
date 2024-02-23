import 'package:equatable/equatable.dart';
import 'package:test/core/error.dart';
import 'package:test/core/result.dart';
import 'package:test/data/repositories/student_repository.dart';
import 'package:test/domain/value_objects/student_status.dart';

final class GetAllStudentsTransaction {
  GetAllStudentsTransaction(this._studentRepository);

  final StudentRepository _studentRepository;

  Future<Result<List<StudentResponse>, ApplicationError>> call(String id) async {
    final students = await _studentRepository.readAll();

    final responses = students
        .map(
          (student) => StudentResponse(
            name: student.name.value,
            email: student.email.value,
            expirationDate: student.status.expirationDate.value,
            type: student.status.type,
          ),
        )
        .toList();

    return Result.value(responses);
  }
}

final class StudentResponse extends Equatable {
  const StudentResponse({
    required this.name,
    required this.email,
    required this.expirationDate,
    required this.type,
  });

  final String name;
  final String email;
  final DateTime expirationDate;
  final StudentAccountType type;

  @override
  List<Object?> get props => [
        name,
        email,
        expirationDate,
        type,
      ];
}
