import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/constants/app_keys.dart';
import 'package:mansaa_app/core/local_storage/local_storage_client.dart';
// import 'package:mansaa_app/core/theme/theme_state.dart';

@singleton
class ThemeManager extends Cubit<ThemeState> {
  final LocalStorageClient _storageClient;
  ThemeManager(this._storageClient) : super(const ThemeState()) {
    getUserThemeMode();
  }

  void changeTheme(ThemeMode themeMode) {
    _storageClient.saveData(key: AppKeys.themeMode, value: themeMode.name);
    emit(state.copyWith(themeMode: themeMode));
  }

  Future<void> getUserThemeMode() async {
    final themeModeStr = await _storageClient.getData(key: AppKeys.themeMode);
    if (themeModeStr != null) {
      try {
        final userSavedThemeMode = ThemeMode.values.firstWhere(
          (e) => e.name == themeModeStr,
          orElse: () => ThemeMode.system,
        );
        emit(state.copyWith(themeMode: userSavedThemeMode));
      } catch (_) {
        emit(state.copyWith(themeMode: ThemeMode.system));
      }
    }
  }
}

class ThemeState extends Equatable {
  final ThemeMode themeMode;
  const ThemeState({this.themeMode = ThemeMode.light});

  @override
  List<Object?> get props => [themeMode];

  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(themeMode: themeMode ?? this.themeMode);
  }
}
