import 'package:pay_pilot_plus/core/data/enums/language_code.dart';
import 'package:pay_pilot_plus/core/utils/resources/data_state.dart';
import 'package:pay_pilot_plus/core/utils/resources/error_response.dart';
import 'package:pay_pilot_plus/features/change_language/data/language_local_provider.dart';

class LanguageRepository {
  final LanguageLocalProvider _localProvider;

  LanguageRepository(this._localProvider);

  Future<DataState<LanguageCode>> fetchLanguageInfo() async {
    try {
      final response = await _localProvider.fetchLanguageInfo();
      final languageCodes = LanguageCode.fromString(response);

      return DataSuccess(languageCodes);
    } catch (e) {
      return DataFailed(ErrorResponse.fromDefault(errorMessage: e.toString()));
    }
  }

  Future<DataState<void>> changeLanguage(LanguageCode languageCodes) async {
    try {
      final response = await _localProvider.changeLanguage(languageCodes.code);

      if (response) {
        return DataSuccess(null);
      }

      return DataFailed(ErrorResponse.fromDefault());
    } catch (e) {
      return DataFailed(ErrorResponse.fromDefault(errorMessage: e.toString()));
    }
  }
}
