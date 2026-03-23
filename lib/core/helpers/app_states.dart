enum AppStates { initial, loading, success, failure }

extension AppStatesExtension on AppStates {
  bool get isInitial => this == AppStates.initial;
  bool get isLoading => this == AppStates.loading;
  bool get isSuccess => this == AppStates.success;
  bool get isFailure => this == AppStates.failure;
}
