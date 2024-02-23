import 'package:test/domain/entities/entity.dart';

final class Course extends Entity {
  Course({
    super.id,
    required CourseAccessTime accessTime,
    required int price,
  })  : _accessTime = accessTime,
        _price = price;

  CourseAccessTime _accessTime;
  int _price;

  CourseAccessTime get accessTime => _accessTime;
  int get price => _price;
}

enum CourseAccessTime {
  infinite,
  oneMonth;
}
