import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'quiz.dart';

part 'quizezs_response.g.dart';

@JsonSerializable()
class QuizzesResponse extends Equatable {
  final List<Quiz>? quizzes;
  final List<dynamic>? warnings;

  const QuizzesResponse({this.quizzes, this.warnings});

  factory QuizzesResponse.fromJson(Map<String, dynamic> json) {
    return _$QuizzesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$QuizzesResponseToJson(this);

  QuizzesResponse copyWith({List<Quiz>? quizzes, List<dynamic>? warnings}) {
    return QuizzesResponse(
      quizzes: quizzes ?? this.quizzes,
      warnings: warnings ?? this.warnings,
    );
  }

  @override
  List<Object?> get props => [quizzes, warnings];
}
