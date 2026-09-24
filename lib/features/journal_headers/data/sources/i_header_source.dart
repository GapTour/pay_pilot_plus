abstract class IHeaderSource<TList> {
  Future<TList> fetchAllHeaders();
}
