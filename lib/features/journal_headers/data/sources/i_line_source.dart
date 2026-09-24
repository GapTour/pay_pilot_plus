abstract class ILineSource<TList> {
  Future<TList> fetchAllLines(int headerID);
}
