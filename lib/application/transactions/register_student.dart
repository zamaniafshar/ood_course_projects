import 'package:equatable/equatable.dart';
import 'package:test/core/error.dart';
import 'package:test/core/result.dart';
import 'package:test/data/repositories/student_repository.dart';
import 'package:test/domain/entities/student.dart';
import 'package:test/domain/value_objects/email.dart';
import 'package:test/domain/value_objects/name.dart';

final class RegisterStudentTransaction {
  RegisterStudentTransaction(this._studentRepository);

  final StudentRepository _studentRepository;

  Future<Result<EmptyValue, ApplicationError>> call(RegisterStudentRequest request) async {
    final name = Name.create(request.name);
    final email = Email.create(request.email);

    final error = Result.combineErrors([name, email]);
    if (error != null) return Result.error(error);

    final student = Student(
      name: name.value,
      email: email.value,
    );

    await _studentRepository.create(student);

    return Result.emptyValue();
  }
}

final class RegisterStudentRequest extends Equatable {
  const RegisterStudentRequest({required this.name, required this.email});

  final String name;
  final String email;

  @override
  List<Object?> get props => [name, email];
}
