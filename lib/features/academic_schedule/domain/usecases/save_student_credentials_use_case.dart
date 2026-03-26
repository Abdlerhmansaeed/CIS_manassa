import 'package:injectable/injectable.dart';
import 'package:mansaa_app/features/academic_schedule/data/models/student_credentials_model.dart';
import 'package:mansaa_app/features/academic_schedule/domain/repositories/academic_schedule_repo.dart';

@injectable
class SaveStudentCredentialsUseCase {
  final AcademicScheduleRepo _repo;

  SaveStudentCredentialsUseCase(this._repo);

  Future<void> call(StudentCredentialsModel credentials) async {
    return await _repo.saveCredentials(credentials);
  }
}
