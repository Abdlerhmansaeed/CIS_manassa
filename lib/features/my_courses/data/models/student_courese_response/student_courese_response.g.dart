// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_courese_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentCourseResponseAdapter extends TypeAdapter<StudentCourseResponse> {
  @override
  final typeId = 0;

  @override
  StudentCourseResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentCourseResponse(
      id: (fields[0] as num?)?.toInt(),
      shortname: fields[1] as String?,
      fullname: fields[2] as String?,
      displayname: fields[3] as String?,
      enrolledusercount: (fields[4] as num?)?.toInt(),
      idnumber: fields[5] as String?,
      visible: (fields[6] as num?)?.toInt(),
      summary: fields[7] as String?,
      summaryformat: (fields[8] as num?)?.toInt(),
      format: fields[9] as String?,
      courseimage: fields[10] as String?,
      showgrades: fields[11] as bool?,
      lang: fields[12] as String?,
      enablecompletion: fields[13] as bool?,
      completionhascriteria: fields[14] as bool?,
      completionusertracked: fields[15] as bool?,
      category: (fields[16] as num?)?.toInt(),
      progress: fields[17] as dynamic,
      completed: fields[18] as bool?,
      startdate: (fields[19] as num?)?.toInt(),
      enddate: (fields[20] as num?)?.toInt(),
      marker: (fields[21] as num?)?.toInt(),
      lastaccess: (fields[22] as num?)?.toInt(),
      isfavourite: fields[23] as bool?,
      hidden: fields[24] as bool?,
      overviewfiles: (fields[25] as List?)?.cast<dynamic>(),
      showactivitydates: fields[26] as bool?,
      showcompletionconditions: fields[27] as bool?,
      timemodified: (fields[28] as num?)?.toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, StudentCourseResponse obj) {
    writer
      ..writeByte(29)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.shortname)
      ..writeByte(2)
      ..write(obj.fullname)
      ..writeByte(3)
      ..write(obj.displayname)
      ..writeByte(4)
      ..write(obj.enrolledusercount)
      ..writeByte(5)
      ..write(obj.idnumber)
      ..writeByte(6)
      ..write(obj.visible)
      ..writeByte(7)
      ..write(obj.summary)
      ..writeByte(8)
      ..write(obj.summaryformat)
      ..writeByte(9)
      ..write(obj.format)
      ..writeByte(10)
      ..write(obj.courseimage)
      ..writeByte(11)
      ..write(obj.showgrades)
      ..writeByte(12)
      ..write(obj.lang)
      ..writeByte(13)
      ..write(obj.enablecompletion)
      ..writeByte(14)
      ..write(obj.completionhascriteria)
      ..writeByte(15)
      ..write(obj.completionusertracked)
      ..writeByte(16)
      ..write(obj.category)
      ..writeByte(17)
      ..write(obj.progress)
      ..writeByte(18)
      ..write(obj.completed)
      ..writeByte(19)
      ..write(obj.startdate)
      ..writeByte(20)
      ..write(obj.enddate)
      ..writeByte(21)
      ..write(obj.marker)
      ..writeByte(22)
      ..write(obj.lastaccess)
      ..writeByte(23)
      ..write(obj.isfavourite)
      ..writeByte(24)
      ..write(obj.hidden)
      ..writeByte(25)
      ..write(obj.overviewfiles)
      ..writeByte(26)
      ..write(obj.showactivitydates)
      ..writeByte(27)
      ..write(obj.showcompletionconditions)
      ..writeByte(28)
      ..write(obj.timemodified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentCourseResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
