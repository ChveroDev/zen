abstract class Dao<T> {
  Future<bool> insert(T object);
  Future<bool> delete(int id);
  Future<T> find(int id);
  Future<bool> deleteAll();
  Future<List<T>> findAll();
}
