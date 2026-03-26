import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mansaa_app/core/network/api_result.dart';
import 'package:mansaa_app/features/academic_schedule/data/models/schedule_item_model.dart';
import 'package:mansaa_app/features/academic_schedule/data/models/student_credentials_model.dart';
import 'package:mansaa_app/features/academic_schedule/domain/repositories/academic_schedule_repo.dart';
import 'package:mansaa_app/features/academic_schedule/domain/usecases/get_acadmic_schedule_use_case.dart';
import 'package:mansaa_app/features/academic_schedule/domain/usecases/get_student_credentials_use_case.dart';
import 'package:mansaa_app/features/academic_schedule/domain/usecases/save_student_credentials_use_case.dart';

class MockAcademicScheduleRepo extends Mock implements AcademicScheduleRepo {}

void main() {
  late MockAcademicScheduleRepo mockRepo;
  late GetAcademicScheduleUseCase getScheduleUseCase;
  late SaveStudentCredentialsUseCase saveCredentialsUseCase;
  late GetStudentCredentialsUseCase getCredentialsUseCase;

  setUp(() {
    mockRepo = MockAcademicScheduleRepo();
    getScheduleUseCase = GetAcademicScheduleUseCase(mockRepo);
    saveCredentialsUseCase = SaveStudentCredentialsUseCase(mockRepo);
    getCredentialsUseCase = GetStudentCredentialsUseCase(mockRepo);
  });

  group('Academic Schedule UseCases', () {
    const tNationalId = '12345678901234';
    const tStudentCode = '20210001';
    final tCredentials = StudentCredentialsModel(
      studentNationalId: tNationalId,
      studentCode: tStudentCode,
    );

    test('should save student credentials via repo', () async {
      when(() => mockRepo.saveCredentials(tCredentials))
          .thenAnswer((_) async => Future.value());

      await saveCredentialsUseCase(tCredentials);

      verify(() => mockRepo.saveCredentials(tCredentials)).called(1);
    });

    test('should get student credentials from repo', () async {
      when(() => mockRepo.getCredentials())
          .thenAnswer((_) async => tCredentials);

      final result = await getCredentialsUseCase();

      expect(result, tCredentials);
      verify(() => mockRepo.getCredentials()).called(1);
    });

    test('should get academic schedule from repo', () async {
      final tScheduleItems = <ScheduleItemModel>[];
      when(() => mockRepo.getAcademicSchedule(
            studentNationalId: tNationalId,
            studentCode: tStudentCode,
            forceRefresh: false,
          )).thenAnswer((_) async => ApiResult.success(tScheduleItems));

      final result = await getScheduleUseCase(
        studentNationalId: tNationalId,
        studentCode: tStudentCode,
      );

      result.when(
        onSuccess: (data) => expect(data, tScheduleItems),
        onFailure: (error) => fail('Should not fail'),
      );
      verify(() => mockRepo.getAcademicSchedule(
            studentNationalId: tNationalId,
            studentCode: tStudentCode,
            forceRefresh: false,
          )).called(1);
    });
  });
}
