import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot_plus/core/data/enums/language_code.dart';
import 'package:pay_pilot_plus/features/change_language/repository/language_repository.dart';

part 'language_state.dart';
part 'status/language_changing_status.dart';
part 'status/material_language_status.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final LanguageRepository _repository;
  LanguageCubit(this._repository)
    : super(
        LanguageState(
          languageChangingStatus: LanguageChangingInit(),
          materialLanguageStatus: MaterialChangingInit(),
        ),
      );

  Future<void> fetchLanguageInfo() async {
    emit(state.copyWith(materialLanguageStatus: MaterialChangingLoading()));

    final dataState = await _repository.fetchLanguageInfo();

    if (dataState.isSuccess) {
      emit(
        state.copyWith(
          materialLanguageStatus: MaterialChangingSuccess(LanguageCode.persian),
        ),
      );
    }

    if (dataState.isFailed) {
      emit(
        state.copyWith(
          materialLanguageStatus: MaterialChangingSuccess(LanguageCode.persian),
        ),
      );
    }
  }

  Future<void> changeLanguage(LanguageCode languageCode) async {
    emit(state.copyWith(languageChangingStatus: LanguageChangingLoading()));

    final dataState = await _repository.changeLanguage(languageCode);

    if (dataState.isSuccess) {
      emit(
        state.copyWith(
          materialLanguageStatus: MaterialChangingSuccess(languageCode),
          languageChangingStatus: LanguageChangingSuccess(),
        ),
      );
    }

    if (dataState.isFailed) {
      emit(
        state.copyWith(
          languageChangingStatus: LanguageChangingFailure(
            dataState.error!.message!,
          ),
        ),
      );
    }
  }

  Future<void> changeLanguageToInit() async {
    emit(state.copyWith(languageChangingStatus: LanguageChangingInit()));
  }
}
