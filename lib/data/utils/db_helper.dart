import 'package:hive/hive.dart';
import 'package:test/data/mappers/mapper.dart';
import 'package:test/domain/entities/entity.dart';

abstract base class DatabaseHelper<M extends Entity> {
  DatabaseHelper(this._box, this._mapper);

  final LazyBox<Map> _box;
  final EntityMapper<M> _mapper;

  Future<void> create(M model) {
    return _box.put(model.id, _mapper.toMap(model));
  }

  Future<void> update(M model) {
    return _box.put(model.id, _mapper.toMap(model));
  }

  Future<M?> read(String key) async {
    final data = await _box.get(key);
    if (data == null) return null;
    return _mapper.fromMap(data);
  }

  Future<List<M>> readAll() {
    return Future.wait(
      _box.keys
          .map(
            (e) => read(e).then((value) => value!),
          )
          .toList(),
    );
  }

  Future<void> delete(String key) async {
    return _box.delete(key);
  }

  Future<void> deleteAll() async {
    await Future.wait(
      _box.keys
          .map(
            (e) => delete(e),
          )
          .toList(),
    );
  }
}
