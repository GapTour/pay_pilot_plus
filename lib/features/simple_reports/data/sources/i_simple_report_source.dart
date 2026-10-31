abstract class ISimpleReportSource<TSalaries, TSummaries, TEvents, TMembers> {
  Future<TSalaries> fetchSalaries({
    DateTime? from,
    DateTime? to,
    int? memberAccountID,
    int? eventAccountID,
  });
  Future<TSummaries> fetchMemberSalarySummaries({
    DateTime? from,
    DateTime? to,
    int? eventAccountID,
  });
  Future<TEvents> fetchEventAccounts();
  Future<TMembers> fetchMemberAccounts();
}
