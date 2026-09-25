import 'package:pay_pilot_plus/core/data/models/fund_balance_model.dart';
import 'package:pay_pilot_plus/core/data/models/fund_model.dart';
import 'package:pay_pilot_plus/core/data/params/fund_params.dart';
import 'package:pay_pilot_plus/core/utils/resources/base_repository.dart';
import 'package:pay_pilot_plus/core/utils/resources/data_state.dart';
import 'package:pay_pilot_plus/features/funds/data/providers/fund_balance_local_provider.dart';
import 'package:pay_pilot_plus/features/funds/data/providers/fund_local_provider.dart';
import 'package:pay_pilot_plus/features/funds/data/sources/i_fund_balance_source.dart';
import 'package:pay_pilot_plus/features/funds/data/sources/i_fund_source.dart';

abstract class IFundRepository
    implements
        IFundSource<
          DataState<FundModel>,
          DataState<int>,
          DataState<List<FundModel>>
        >,
        IFundBalanceSource<
          DataState<BigInt>,
          DataState<List<FundBalanceModel>>
        > {}

class FundRepository extends BaseRepository implements IFundRepository {
  final IFundLocalProvider _fundLocalProvider;
  final IFundBalanceLocalProvider _balanceLocalProvider;

  FundRepository(this._fundLocalProvider, this._balanceLocalProvider);

  @override
  Future<DataState<int>> archiveFund(int id) {
    return safeDbCall(() => _fundLocalProvider.archiveFund(id));
  }

  @override
  Future<DataState<List<FundModel>>> fetchAllFunds() {
    return safeDbCall(() => _fundLocalProvider.fetchAllFunds());
  }

  @override
  Future<DataState<FundModel>> insertFund(FundParams params) {
    return safeDbCall(() => _fundLocalProvider.insertFund(params));
  }

  @override
  Future<DataState<FundModel>> updateFund(FundParams params) {
    return safeDbCall(() => _fundLocalProvider.updateFund(params));
  }

  @override
  Future<DataState<BigInt>> calculateFundsRemaining({
    required BigInt openingBalance,
    required List<FundBalanceModel> fundBalances,
  }) {
    return safeDbCall(
      () => _balanceLocalProvider.calculateFundsRemaining(
        openingBalance: openingBalance,
        fundBalances: fundBalances,
      ),
    );
  }

  @override
  Future<DataState<List<FundBalanceModel>>> fetchFund(int fundID) {
    return safeDbCall(() => _balanceLocalProvider.fetchFund(fundID));
  }
}
