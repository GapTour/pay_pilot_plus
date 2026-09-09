import 'package:pay_pilot_plus/core/utils/resources/base_repository.dart';
import 'package:pay_pilot_plus/core/utils/resources/data_state.dart';
import 'package:pay_pilot_plus/features/settings/data/providers/setting_local_provider.dart';
import 'package:pay_pilot_plus/features/settings/data/sources/i_setting_source.dart';
import 'package:share_plus/share_plus.dart';

abstract class ISettingRepository
    implements ISettingSource<DataState<ShareParams>, DataState<bool>> {}

class SettingRepository extends BaseRepository implements ISettingRepository {
  final ISettingLocalProvider _localProvider;
  late bool isWeb;

  SettingRepository(this._localProvider);

  @override
  Future<DataState<ShareParams>> createNativeBackup() {
    return safeDbCall(() => _localProvider.createNativeBackup());
  }

  @override
  Future<DataState<bool>> restoreNativeBackup() async {
    return safeDbCall(() => _localProvider.restoreNativeBackup());
  }
}
