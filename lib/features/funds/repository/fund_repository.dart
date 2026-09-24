import 'package:pay_pilot_plus/core/data/models/fund_model.dart';
import 'package:pay_pilot_plus/core/data/params/fund_params.dart';
import 'package:pay_pilot_plus/core/utils/resources/base_repository.dart';
import 'package:pay_pilot_plus/core/utils/resources/data_state.dart';
import 'package:pay_pilot_plus/features/funds/data/providers/fund_local_provider.dart';
import 'package:pay_pilot_plus/features/funds/data/sources/i_fund_source.dart';

abstract class IFundRepository
    implements
        IFundSource<
          DataState<FundModel>,
          DataState<int>,
          DataState<List<FundModel>>
        > {}

class FundRepository extends BaseRepository implements IFundRepository {
  final IFundLocalProvider _localProvider;

  FundRepository(this._localProvider);

  @override
  Future<DataState<int>> archiveFund(int id) {
    return safeDbCall(() => _localProvider.archiveFund(id));
  }

  @override
  Future<DataState<List<FundModel>>> fetchAllFunds() {
    return safeDbCall(() => _localProvider.fetchAllFunds());
  }

  @override
  Future<DataState<FundModel>> insertFund(FundParams params) {
    return safeDbCall(() => _localProvider.insertFund(params));
  }

  @override
  Future<DataState<FundModel>> updateFund(FundParams params) {
    return safeDbCall(() => _localProvider.updateFund(params));
  }
}
