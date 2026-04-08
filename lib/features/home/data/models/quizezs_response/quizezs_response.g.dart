// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quizezs_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizzesResponse _$QuizzesResponseFromJson(Map<String, dynamic> json) =>
    QuizzesResponse(
      quizzes: (json['quizzes'] as List<dynamic>?)
          ?.map((e) => Quiz.fromJson(e as Map<String, dynamic>))
          .toList(),
      warnings: json['warnings'] as List<dynamic>?,
    );

Map<String, dynamic> _$QuizzesResponseToJson(QuizzesResponse instance) =>
    <String, dynamic>{
      'quizzes': instance.quizzes,
      'warnings': instance.warnings,
    };
