abstract class IReportSource<THeaders, TLines, TSubsidiaries, TDetaileds> {
  Future<THeaders> fetchHeaders({DateTime? from, DateTime? to});
  Future<TLines> fetchLines({
    DateTime? from,
    DateTime? to,
    int? subsidiaryID,
    int? detailedID,
  });
  Future<TSubsidiaries> fetchAllSubsidiaries();
  Future<TDetaileds> fetchAllDetailedAccounts();
}
