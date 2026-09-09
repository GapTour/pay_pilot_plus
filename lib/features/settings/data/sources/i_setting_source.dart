// abstract class IBackupSource {
//   Future<DataState<ShareParams>> createNativeBackup();
//   Future<DataState<void>> restoreNativeBackup();
// }
abstract class ISettingSource<TBackup, TBool> {
  Future<TBackup> createNativeBackup();
  Future<TBool> restoreNativeBackup();
}
