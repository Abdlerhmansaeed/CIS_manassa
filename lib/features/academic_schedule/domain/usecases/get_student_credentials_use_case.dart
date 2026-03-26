import 'package:injectable/injectable.dart';
import 'package:mansaa_app/features/academic_schedule/data/models/student_credentials_model.dart';
import 'package:mansaa_app/features/academic_schedule/domain/repositories/academic_schedule_repo.dart';

@injectable
class GetStudentCredentialsUseCase {
  final AcademicScheduleRepo _repo;

  GetStudentCredentialsUseCase(this._repo);

  Future<StudentCredentialsModel?> call() async {
    return await _repo.getCredentials();
  }
}
