import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:pay_pilot_plus/core/utils/resources/data_state.dart';
import 'package:pay_pilot_plus/core/utils/resources/error_response.dart';

class PickFileHelper {
  static Future<DataState<Uint8List>> pickJsonFile() async {
    try {
      late Uint8List bytes;
      final result = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result == null) {
        return DataFailed(
          ErrorResponse.fromDefault(
            errorMessage: 'No file selected',
            code: 600,
          ),
        );
      }

      if (!kIsWeb) {
        bytes = await result.xFile.readAsBytes();

        return DataSuccess(bytes);
      }

      return DataFailed(
        ErrorResponse.fromDefault(
          errorMessage: 'Invalid file selected',
          code: 600,
        ),
      );
    } catch (e) {
      return DataFailed(
        ErrorResponse.fromDefault(errorMessage: '$e', code: 600),
      );
    }
  }

  static Future<DataState<PlatformFile>> pickSqliteFile() async {
    try {
      final PlatformFile? result = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: ['sqlite', 'sqflite'],
      );

      if (result == null) {
        return DataFailed(
          ErrorResponse.fromDefault(
            errorMessage: 'No file selected',
            code: 600,
          ),
        );
      }

      final pickedFile = result.xFile;

      if (!pickedFile.name.endsWith('.sqlite')) {
        return DataFailed(
          ErrorResponse.fromDefault(
            errorMessage: 'Selected file is not valid',
            code: 600,
          ),
        );
      }

      return DataSuccess(result);
    } catch (e) {
      return DataFailed(
        ErrorResponse.fromDefault(errorMessage: '$e', code: 600),
      );
    }
  }
}
