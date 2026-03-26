import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'student_credentials_model.g.dart';

@JsonSerializable()
class StudentCredentialsModel extends Equatable {
  final String studentNationalId;
  final String? studentCode;

  const StudentCredentialsModel({
    required this.studentNationalId,
    this.studentCode,
  });

  factory StudentCredentialsModel.fromJson(Map<String, dynamic> json) =>
      _$StudentCredentialsModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudentCredentialsModelToJson(this);

  @override
  List<Object?> get props => [studentNationalId, studentCode];
}
