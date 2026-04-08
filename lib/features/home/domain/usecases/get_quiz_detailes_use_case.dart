import 'package:injectable/injectable.dart';
import 'package:mansaa_app/core/network/api_result.dart';
import 'package:mansaa_app/features/home/data/models/quizezs_response/quiz.dart';
import 'package:mansaa_app/features/home/domain/repositories/home_repo.dart';

@injectable
class GetQuizDetailsUseCase {
  final HomeRepo _repo;

  GetQuizDetailsUseCase(this._repo);

  Future<ApiResult<Quiz>> call({
    required int courseId,
    required int quizId,
  }) async {
    final request = await _repo.getStudentQuizzes(courseId: courseId);

    return request.when(
      onSuccess: (allQuizzes) {
        final currentQuizDetails = allQuizzes.quizzes?.firstWhere(
          (quiz) => quiz.coursemodule == quizId,
        );
        return ApiResult.success(currentQuizDetails ?? const Quiz());
      },
      onFailure: (error) {
        return ApiResult.failure(error);
      },
    );
  }
}
