// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
  id: (json['id'] as num?)?.toInt(),
  fullname: json['fullname'] as String?,
  shortname: json['shortname'] as String?,
  idnumber: json['idnumber'] as String?,
  summary: json['summary'] as String?,
  summaryformat: (json['summaryformat'] as num?)?.toInt(),
  startdate: (json['startdate'] as num?)?.toInt(),
  enddate: (json['enddate'] as num?)?.toInt(),
  visible: json['visible'] as bool?,
  showactivitydates: json['showactivitydates'] as bool?,
  showcompletionconditions: json['showcompletionconditions'] as bool?,
  pdfexportfont: json['pdfexportfont'] as String?,
  fullnamedisplay: json['fullnamedisplay'] as String?,
  viewurl: json['viewurl'] as String?,
  courseimage: json['courseimage'] as String?,
  progress: (json['progress'] as num?)?.toInt(),
  hasprogress: json['hasprogress'] as bool?,
  isfavourite: json['isfavourite'] as bool?,
  hidden: json['hidden'] as bool?,
  showshortname: json['showshortname'] as bool?,
  coursecategory: json['coursecategory'] as String?,
);

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
  'id': instance.id,
  'fullname': instance.fullname,
  'shortname': instance.shortname,
  'idnumber': instance.idnumber,
  'summary': instance.summary,
  'summaryformat': instance.summaryformat,
  'startdate': instance.startdate,
  'enddate': instance.enddate,
  'visible': instance.visible,
  'showactivitydates': instance.showactivitydates,
  'showcompletionconditions': instance.showcompletionconditions,
  'pdfexportfont': instance.pdfexportfont,
  'fullnamedisplay': instance.fullnamedisplay,
  'viewurl': instance.viewurl,
  'courseimage': instance.courseimage,
  'progress': instance.progress,
  'hasprogress': instance.hasprogress,
  'isfavourite': instance.isfavourite,
  'hidden': instance.hidden,
  'showshortname': instance.showshortname,
  'coursecategory': instance.coursecategory,
};
