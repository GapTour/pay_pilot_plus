abstract class IEventDetailsSource<TBanks, TUsers, TFunds, TMenuItems> {
  Future<TBanks> fetchAllBanks();
  Future<TUsers> fetchAllUsers();
  Future<TFunds> fetchAllFunds();
  Future<TMenuItems> fetchAllMenuItems();
}
