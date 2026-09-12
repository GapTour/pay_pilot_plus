abstract class IEventDetailsSource<TBanks, TUsers, TMenuItems> {
  Future<TBanks> fetchAllBanks();
  Future<TUsers> fetchAllUsers();
  Future<TMenuItems> fetchAllMenuItems();
}
