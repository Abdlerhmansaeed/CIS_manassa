// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quiz _$QuizFromJson(Map<String, dynamic> json) => Quiz(
  id: (json['id'] as num?)?.toInt(),
  coursemodule: (json['coursemodule'] as num?)?.toInt(),
  course: (json['course'] as num?)?.toInt(),
  name: json['name'] as String?,
  intro: json['intro'] as String?,
  introformat: (json['introformat'] as num?)?.toInt(),
  introfiles: json['introfiles'] as List<dynamic>?,
  section: (json['section'] as num?)?.toInt(),
  visible: json['visible'] as bool?,
  groupmode: (json['groupmode'] as num?)?.toInt(),
  groupingid: (json['groupingid'] as num?)?.toInt(),
  lang: json['lang'] as String?,
  timeopen: (json['timeopen'] as num?)?.toInt(),
  timeclose: (json['timeclose'] as num?)?.toInt(),
  timelimit: (json['timelimit'] as num?)?.toInt(),
  preferredbehaviour: json['preferredbehaviour'] as String?,
  attempts: (json['attempts'] as num?)?.toInt(),
  grademethod: (json['grademethod'] as num?)?.toInt(),
  decimalpoints: (json['decimalpoints'] as num?)?.toInt(),
  questiondecimalpoints: (json['questiondecimalpoints'] as num?)?.toInt(),
  sumgrades: (json['sumgrades'] as num?)?.toInt(),
  grade: (json['grade'] as num?)?.toInt(),
  hasfeedback: (json['hasfeedback'] as num?)?.toInt(),
);

Map<String, dynamic> _$QuizToJson(Quiz instance) => <String, dynamic>{
  'id': instance.id,
  'coursemodule': instance.coursemodule,
  'course': instance.course,
  'name': instance.name,
  'intro': instance.intro,
  'introformat': instance.introformat,
  'introfiles': instance.introfiles,
  'section': instance.section,
  'visible': instance.visible,
  'groupmode': instance.groupmode,
  'groupingid': instance.groupingid,
  'lang': instance.lang,
  'timeopen': instance.timeopen,
  'timeclose': instance.timeclose,
  'timelimit': instance.timelimit,
  'preferredbehaviour': instance.preferredbehaviour,
  'attempts': instance.attempts,
  'grademethod': instance.grademethod,
  'decimalpoints': instance.decimalpoints,
  'questiondecimalpoints': instance.questiondecimalpoints,
  'sumgrades': instance.sumgrades,
  'grade': instance.grade,
  'hasfeedback': instance.hasfeedback,
};
