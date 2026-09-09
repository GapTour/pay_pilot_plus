import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot_plus/core/utils/resources/error_response.dart';
import 'package:pay_pilot_plus/features/settings/repository/setting_repository.dart';
import 'package:share_plus/share_plus.dart';

part 'backup_event.dart';
part 'backup_state.dart';
part 'status/export_status.dart';
part 'status/import_status.dart';

class BackupBloc extends Bloc<BackupEvent, BackupState> {
  final ISettingRepository _repository;
  BackupBloc(this._repository)
    : super(
        BackupState(exportStatus: ExportInit(), importStatus: ImportInit()),
      ) {
    on<ChangeToInit>((event, emit) async {
      emit(
        state.copyWith(exportStatus: ExportInit(), importStatus: ImportInit()),
      );
    });
    on<ExportBackupRequested>((event, emit) async {
      emit(state.copyWith(exportStatus: ExportLoading()));

      final dataState = await _repository.createNativeBackup();

      if (dataState.isSuccess) {
        emit(state.copyWith(exportStatus: ExportFetched(dataState.response!)));
      }

      if (dataState.isFailed) {
        emit(state.copyWith(exportStatus: ExportFailure(dataState.error!)));
      }
    });
    on<ImportBackupRequested>((event, emit) async {
      emit(state.copyWith(importStatus: ImportLoading()));

      final dataState = await _repository.restoreNativeBackup();

      if (dataState.isSuccess) {
        emit(state.copyWith(importStatus: ImportFetched()));
      }

      if (dataState.isFailed) {
        emit(state.copyWith(importStatus: ImportFailure(dataState.error!)));
      }
    });
  }
}
