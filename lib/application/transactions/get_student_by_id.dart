import 'package:equatable/equatable.dart';
import 'package:test/core/error.dart';
import 'package:test/core/result.dart';
import 'package:test/data/repositories/student_repository.dart';
import 'package:test/domain/value_objects/student_status.dart';

final class GetStudentByIdTransaction {
  GetStudentByIdTransaction(this._studentRepository);

  final StudentRepository _studentRepository;

  Future<Result<GetStudentByIdResponse, ApplicationError>> call(String id) async {
    final student = await _studentRepository.read(id);
    if (student == null) return Result.error(ApplicationError('User not found'));

    final response = GetStudentByIdResponse(
      name: student.name.value,
      email: student.email.value,
      expirationDate: student.status.expirationDate.value,
      type: student.status.type,
    );

    return Result.value(response);
  }
}

final class GetStudentByIdResponse extends Equatable {
  const GetStudentByIdResponse({
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
