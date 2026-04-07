import 'package:equatable/equatable.dart';
import 'package:hive_ce/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'student_courese_response.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class StudentCourseResponse extends Equatable {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? shortname;
  @HiveField(2)
  final String? fullname;
  @HiveField(3)
  final String? displayname;
  @HiveField(4)
  final int? enrolledusercount;
  @HiveField(5)
  final String? idnumber;
  @HiveField(6)
  final int? visible;
  @HiveField(7)
  final String? summary;
  @HiveField(8)
  final int? summaryformat;
  @HiveField(9)
  final String? format;
  @HiveField(10)
  final String? courseimage;
  @HiveField(11)
  final bool? showgrades;
  @HiveField(12)
  final String? lang;
  @HiveField(13)
  final bool? enablecompletion;
  @HiveField(14)
  final bool? completionhascriteria;
  @HiveField(15)
  final bool? completionusertracked;
  @HiveField(16)
  final int? category;
  @HiveField(17)
  final dynamic progress;
  @HiveField(18)
  final bool? completed;
  @HiveField(19)
  final int? startdate;
  @HiveField(20)
  final int? enddate;
  @HiveField(21)
  final int? marker;
  @HiveField(22)
  final int? lastaccess;
  @HiveField(23)
  final bool? isfavourite;
  @HiveField(24)
  final bool? hidden;
  @HiveField(25)
  final List<dynamic>? overviewfiles;
  @HiveField(26)
  final bool? showactivitydates;
  @HiveField(27)
  final bool? showcompletionconditions;
  @HiveField(28)
  final int? timemodified;

  const StudentCourseResponse({
    this.id,
    this.shortname,
    this.fullname,
    this.displayname,
    this.enrolledusercount,
    this.idnumber,
    this.visible,
    this.summary,
    this.summaryformat,
    this.format,
    this.courseimage,
    this.showgrades,
    this.lang,
    this.enablecompletion,
    this.completionhascriteria,
    this.completionusertracked,
    this.category,
    this.progress,
    this.completed,
    this.startdate,
    this.enddate,
    this.marker,
    this.lastaccess,
    this.isfavourite,
    this.hidden,
    this.overviewfiles,
    this.showactivitydates,
    this.showcompletionconditions,
    this.timemodified,
  });

  factory StudentCourseResponse.fromJson(Map<String, dynamic> json) {
    return _$StudentCourseResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$StudentCourseResponseToJson(this);

  StudentCourseResponse copyWith({
    int? id,
    String? shortname,
    String? fullname,
    String? displayname,
    int? enrolledusercount,
    String? idnumber,
    int? visible,
    String? summary,
    int? summaryformat,
    String? format,
    String? courseimage,
    bool? showgrades,
    String? lang,
    bool? enablecompletion,
    bool? completionhascriteria,
    bool? completionusertracked,
    int? category,
    dynamic progress,
    bool? completed,
    int? startdate,
    int? enddate,
    int? marker,
    int? lastaccess,
    bool? isfavourite,
    bool? hidden,
    List<dynamic>? overviewfiles,
    bool? showactivitydates,
    bool? showcompletionconditions,
    int? timemodified,
  }) {
    return StudentCourseResponse(
      id: id ?? this.id,
      shortname: shortname ?? this.shortname,
      fullname: fullname ?? this.fullname,
      displayname: displayname ?? this.displayname,
      enrolledusercount: enrolledusercount ?? this.enrolledusercount,
      idnumber: idnumber ?? this.idnumber,
      visible: visible ?? this.visible,
      summary: summary ?? this.summary,
      summaryformat: summaryformat ?? this.summaryformat,
      format: format ?? this.format,
      courseimage: courseimage ?? this.courseimage,
      showgrades: showgrades ?? this.showgrades,
      lang: lang ?? this.lang,
      enablecompletion: enablecompletion ?? this.enablecompletion,
      completionhascriteria:
          completionhascriteria ?? this.completionhascriteria,
      completionusertracked:
          completionusertracked ?? this.completionusertracked,
      category: category ?? this.category,
      progress: progress ?? this.progress,
      completed: completed ?? this.completed,
      startdate: startdate ?? this.startdate,
      enddate: enddate ?? this.enddate,
      marker: marker ?? this.marker,
      lastaccess: lastaccess ?? this.lastaccess,
      isfavourite: isfavourite ?? this.isfavourite,
      hidden: hidden ?? this.hidden,
      overviewfiles: overviewfiles ?? this.overviewfiles,
      showactivitydates: showactivitydates ?? this.showactivitydates,
      showcompletionconditions:
          showcompletionconditions ?? this.showcompletionconditions,
      timemodified: timemodified ?? this.timemodified,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      shortname,
      fullname,
      displayname,
      enrolledusercount,
      idnumber,
      visible,
      summary,
      summaryformat,
      format,
      courseimage,
      showgrades,
      lang,
      enablecompletion,
      completionhascriteria,
      completionusertracked,
      category,
      progress,
      completed,
      startdate,
      enddate,
      marker,
      lastaccess,
      isfavourite,
      hidden,
      overviewfiles,
      showactivitydates,
      showcompletionconditions,
      timemodified,
    ];
  }
}
