import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

base class Entity with EquatableMixin {
  static const initialId = '-1';

  Entity({String id = initialId}) : _id = id == initialId ? _uuid.v4() : id;

  final String _id;

  String get id {
    if (_id == initialId) throw InvalidEntityIdError();
    return _id;
  }

  @override
  List<Object?> get props => [id];
}

final class InvalidEntityIdError extends ArgumentError {
  InvalidEntityIdError() : super('System try to use an entity with Initial Id');
}
