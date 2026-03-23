import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'student_courese_response.g.dart';

@JsonSerializable()
class StudentCourseResponse extends Equatable {
  final int? id;
  final String? shortname;
  final String? fullname;
  final String? displayname;
  final int? enrolledusercount;
  final String? idnumber;
  final int? visible;
  final String? summary;
  final int? summaryformat;
  final String? format;
  final String? courseimage;
  final bool? showgrades;
  final String? lang;
  final bool? enablecompletion;
  final bool? completionhascriteria;
  final bool? completionusertracked;
  final int? category;
  final dynamic progress;
  final bool? completed;
  final int? startdate;
  final int? enddate;
  final int? marker;
  final int? lastaccess;
  final bool? isfavourite;
  final bool? hidden;
  final List<dynamic>? overviewfiles;
  final bool? showactivitydates;
  final bool? showcompletionconditions;
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
