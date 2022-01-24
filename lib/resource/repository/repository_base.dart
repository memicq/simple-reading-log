abstract class RepositoryBase<T> {
  Future<void> create(String userId, T row);
  Future<List<T>> list(String userId);
  Future<void> delete(String userId, String documentId);
  Future<void> update(String userId, T updatedRow);
}
