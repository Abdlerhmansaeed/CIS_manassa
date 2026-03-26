// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_credentials_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentCredentialsModel _$StudentCredentialsModelFromJson(
  Map<String, dynamic> json,
) => StudentCredentialsModel(
  studentNationalId: json['studentNationalId'] as String,
  studentCode: json['studentCode'] as String?,
);

Map<String, dynamic> _$StudentCredentialsModelToJson(
  StudentCredentialsModel instance,
) => <String, dynamic>{
  'studentNationalId': instance.studentNationalId,
  'studentCode': instance.studentCode,
};
