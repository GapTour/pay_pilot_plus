import 'package:drift/drift.dart';
import 'package:pay_pilot_plus/core/data/params/fund_allocation_params.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';

part 'fund_allocations_dao.g.dart';

@DriftAccessor(tables: [Funds, Events, Teams, TeamFunds, FundAllocations])
class FundAllocationsDao extends DatabaseAccessor<AppDatabase>
    with _$FundAllocationsDaoMixin {
  FundAllocationsDao(super.db);

  Future<int> insertFundRatio(FundAllocationParams params) async {
    return await transaction(() async {
      return await into(fundAllocations).insert(
        FundAllocationsCompanion(
          sharePercentage: Value(params.fundsInfo.first.ratio),
          eventID: Value(params.eventInfo.id),
          fundID: Value(params.fundsInfo.first.id),
        ),
      );
    });
  }

  Future<void> insertMultiFundRatio(FundAllocationParams params) async {
    return await transaction(() async {
      return await batch((batch) {
        batch.insertAll(
          fundAllocations,
          params.fundsInfo.map((row) {
            return FundAllocationsCompanion.insert(
              sharePercentage: row.ratio,
              eventID: params.eventInfo.id,
              fundID: row.id,
            );
          }),
        );
      });
    });
  }

  Future<List<({FundAllocation fundAllocation, Fund fund})>> fetchAllFundRatios(
    int eventID,
  ) async {
    final query =
        (select(
          fundAllocations,
        )..where((tbl) => tbl.eventID.equals(eventID))).join([
          innerJoin(funds, funds.id.equalsExp(fundAllocations.fundID)),
        ]);

    final rows = await query.get();

    return rows.map((row) {
      final fundAllocation = row.readTable(fundAllocations);
      final fund = row.readTable(funds);

      return (fundAllocation: fundAllocation, fund: fund);
    }).toList();
  }

  Future<int> updateFundRatio(FundAllocationParams params) async {
    return await transaction(() async {
      return await (update(
        fundAllocations,
      )..where((tbl) => tbl.id.equals(params.id!))).write(
        FundAllocationsCompanion(
          sharePercentage: Value(params.fundsInfo.first.ratio),
        ),
      );
    });
  }

  Future<int> deleteFundRatio(int id) async {
    return await transaction(() async {
      return await (delete(
        fundAllocations,
      )..where((tbl) => tbl.id.equals(id))).go();
    });
  }

  Future<int> deleteAllFundRatiosByEvent(int eventID) async {
    return await transaction(() async {
      return await (db.delete(
        fundAllocations,
      )..where((tbl) => tbl.eventID.equals(eventID))).go();
    });
  }
}
