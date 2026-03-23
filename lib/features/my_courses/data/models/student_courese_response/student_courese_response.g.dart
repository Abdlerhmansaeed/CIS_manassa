// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_courese_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentCourseResponse _$StudentCourseResponseFromJson(
  Map<String, dynamic> json,
) => StudentCourseResponse(
  id: (json['id'] as num?)?.toInt(),
  shortname: json['shortname'] as String?,
  fullname: json['fullname'] as String?,
  displayname: json['displayname'] as String?,
  enrolledusercount: (json['enrolledusercount'] as num?)?.toInt(),
  idnumber: json['idnumber'] as String?,
  visible: (json['visible'] as num?)?.toInt(),
  summary: json['summary'] as String?,
  summaryformat: (json['summaryformat'] as num?)?.toInt(),
  format: json['format'] as String?,
  courseimage: json['courseimage'] as String?,
  showgrades: json['showgrades'] as bool?,
  lang: json['lang'] as String?,
  enablecompletion: json['enablecompletion'] as bool?,
  completionhascriteria: json['completionhascriteria'] as bool?,
  completionusertracked: json['completionusertracked'] as bool?,
  category: (json['category'] as num?)?.toInt(),
  progress: json['progress'],
  completed: json['completed'] as bool?,
  startdate: (json['startdate'] as num?)?.toInt(),
  enddate: (json['enddate'] as num?)?.toInt(),
  marker: (json['marker'] as num?)?.toInt(),
  lastaccess: (json['lastaccess'] as num?)?.toInt(),
  isfavourite: json['isfavourite'] as bool?,
  hidden: json['hidden'] as bool?,
  overviewfiles: json['overviewfiles'] as List<dynamic>?,
  showactivitydates: json['showactivitydates'] as bool?,
  showcompletionconditions: json['showcompletionconditions'] as bool?,
  timemodified: (json['timemodified'] as num?)?.toInt(),
);

Map<String, dynamic> _$StudentCourseResponseToJson(
  StudentCourseResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'shortname': instance.shortname,
  'fullname': instance.fullname,
  'displayname': instance.displayname,
  'enrolledusercount': instance.enrolledusercount,
  'idnumber': instance.idnumber,
  'visible': instance.visible,
  'summary': instance.summary,
  'summaryformat': instance.summaryformat,
  'format': instance.format,
  'courseimage': instance.courseimage,
  'showgrades': instance.showgrades,
  'lang': instance.lang,
  'enablecompletion': instance.enablecompletion,
  'completionhascriteria': instance.completionhascriteria,
  'completionusertracked': instance.completionusertracked,
  'category': instance.category,
  'progress': instance.progress,
  'completed': instance.completed,
  'startdate': instance.startdate,
  'enddate': instance.enddate,
  'marker': instance.marker,
  'lastaccess': instance.lastaccess,
  'isfavourite': instance.isfavourite,
  'hidden': instance.hidden,
  'overviewfiles': instance.overviewfiles,
  'showactivitydates': instance.showactivitydates,
  'showcompletionconditions': instance.showcompletionconditions,
  'timemodified': instance.timemodified,
};
