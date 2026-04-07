import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quiz.g.dart';

@JsonSerializable()
class Quiz extends Equatable {
  final int? id;
  final int? coursemodule;
  final int? course;
  final String? name;
  final String? intro;
  final int? introformat;
  final List<dynamic>? introfiles;
  final int? section;
  final bool? visible;
  final int? groupmode;
  final int? groupingid;
  final String? lang;
  final int? timeopen;
  final int? timeclose;
  final int? timelimit;
  final String? preferredbehaviour;
  final int? attempts;
  final int? grademethod;
  final int? decimalpoints;
  final int? questiondecimalpoints;
  final int? sumgrades;
  final int? grade;
  final int? hasfeedback;

  const Quiz({
    this.id,
    this.coursemodule,
    this.course,
    this.name,
    this.intro,
    this.introformat,
    this.introfiles,
    this.section,
    this.visible,
    this.groupmode,
    this.groupingid,
    this.lang,
    this.timeopen,
    this.timeclose,
    this.timelimit,
    this.preferredbehaviour,
    this.attempts,
    this.grademethod,
    this.decimalpoints,
    this.questiondecimalpoints,
    this.sumgrades,
    this.grade,
    this.hasfeedback,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);

  Map<String, dynamic> toJson() => _$QuizToJson(this);

  Quiz copyWith({
    int? id,
    int? coursemodule,
    int? course,
    String? name,
    String? intro,
    int? introformat,
    List<dynamic>? introfiles,
    int? section,
    bool? visible,
    int? groupmode,
    int? groupingid,
    String? lang,
    int? timeopen,
    int? timeclose,
    int? timelimit,
    String? preferredbehaviour,
    int? attempts,
    int? grademethod,
    int? decimalpoints,
    int? questiondecimalpoints,
    int? sumgrades,
    int? grade,
    int? hasfeedback,
  }) {
    return Quiz(
      id: id ?? this.id,
      coursemodule: coursemodule ?? this.coursemodule,
      course: course ?? this.course,
      name: name ?? this.name,
      intro: intro ?? this.intro,
      introformat: introformat ?? this.introformat,
      introfiles: introfiles ?? this.introfiles,
      section: section ?? this.section,
      visible: visible ?? this.visible,
      groupmode: groupmode ?? this.groupmode,
      groupingid: groupingid ?? this.groupingid,
      lang: lang ?? this.lang,
      timeopen: timeopen ?? this.timeopen,
      timeclose: timeclose ?? this.timeclose,
      timelimit: timelimit ?? this.timelimit,
      preferredbehaviour: preferredbehaviour ?? this.preferredbehaviour,
      attempts: attempts ?? this.attempts,
      grademethod: grademethod ?? this.grademethod,
      decimalpoints: decimalpoints ?? this.decimalpoints,
      questiondecimalpoints:
          questiondecimalpoints ?? this.questiondecimalpoints,
      sumgrades: sumgrades ?? this.sumgrades,
      grade: grade ?? this.grade,
      hasfeedback: hasfeedback ?? this.hasfeedback,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      coursemodule,
      course,
      name,
      intro,
      introformat,
      introfiles,
      section,
      visible,
      groupmode,
      groupingid,
      lang,
      timeopen,
      timeclose,
      timelimit,
      preferredbehaviour,
      attempts,
      grademethod,
      decimalpoints,
      questiondecimalpoints,
      sumgrades,
      grade,
      hasfeedback,
    ];
  }
}
