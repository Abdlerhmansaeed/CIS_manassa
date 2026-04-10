import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/constants/app_constants.dart';
import 'package:mansaa_app/core/constants/app_keys.dart';
import 'package:mansaa_app/core/local_storage/local_storage_client.dart';

@singleton
class LanguagesManager extends Cubit<LanguagesState> {
  final LocalStorageClient _storageClient;
  LanguagesManager(this._storageClient) : super(const LanguagesState()) {
    getUserLanguage();
  }

  void changeLanguage(String language) {
    _storageClient.saveData(key: AppKeys.language, value: language);
    emit(state.copyWith(language: language));
  }

  provideLanguages() {
    return AppConstants.availableLanguages;
  }

  Future<void> getUserLanguage() async {
    final language = await _storageClient.getData(key: AppKeys.language);
    if (language != null) {
      emit(state.copyWith(language: language));
    }
  }
}

class LanguagesState {
  final String language;
  const LanguagesState({this.language = 'en'});

  LanguagesState copyWith({String? language}) {
    return LanguagesState(language: language ?? this.language);
  }
}
