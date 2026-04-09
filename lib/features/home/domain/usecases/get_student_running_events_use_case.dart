import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/network/api_result.dart';
import 'package:mansaa_app/features/home/data/models/student_calander_events_response/student_calander_events_response.dart';
import 'package:mansaa_app/features/home/domain/repositories/home_repo.dart';

@injectable
class GetStudentRunningEventsUseCase {
  final HomeRepo _repo;
  GetStudentRunningEventsUseCase(this._repo);

  Future<ApiResult<StudentCalanderEventsResponse>> call() async {
    final request = await _repo.getStudentCalenderEvents();
    return request.when(
      onSuccess: (data) {
        final currentTimeInSeconds =
            DateTime.now().millisecondsSinceEpoch ~/ 1000;

        final userUpcomingEventsAndActionable = data.events?.where((event) {
          final isActionable = event.action?.actionable == true;
          final isFutureEvent = (event.timestart ?? 0) > currentTimeInSeconds;

          return isFutureEvent || isActionable;
        }).toList();

        final userEvents = data.copyWith(
          events: userUpcomingEventsAndActionable,
        );
        return ApiResult.success(userEvents);
      },
      onFailure: (failure) {
        return ApiResult.failure(failure);
      },
    );
  }
}
