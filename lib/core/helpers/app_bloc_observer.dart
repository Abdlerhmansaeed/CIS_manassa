import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansaa_app/core/helpers/logger.dart';

/// A custom BlocObserver that logs Bloc/Cubit lifecycle events.
/// Uses [Logger] with a 'BLoC' tag so events are easy to filter in the console.
class AppBlocObserver extends BlocObserver {
  static const _tag = 'BLoC';

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    Logger.debug('Created  → ${bloc.runtimeType}', _tag);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    Logger.info('Event    → ${bloc.runtimeType}  •  $event', _tag);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    Logger.info(
      'Change   → ${bloc.runtimeType}\n'
      '             prev: ${change.currentState}\n'
      '             next: ${change.nextState}',
      _tag,
    );
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    Logger.debug(
      'Transition → ${bloc.runtimeType}  •  event: ${transition.event}',
      _tag,
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    Logger.error('Error in ${bloc.runtimeType}', error, stackTrace, _tag);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    Logger.debug('Closed   → ${bloc.runtimeType}', _tag);
  }
}
