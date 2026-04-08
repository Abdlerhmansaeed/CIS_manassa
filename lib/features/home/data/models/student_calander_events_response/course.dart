import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

@JsonSerializable()
class Course extends Equatable {
  final int? id;
  final String? fullname;
  final String? shortname;
  final String? idnumber;
  final String? summary;
  final int? summaryformat;
  final int? startdate;
  final int? enddate;
  final bool? visible;
  final bool? showactivitydates;
  final bool? showcompletionconditions;
  final String? pdfexportfont;
  final String? fullnamedisplay;
  final String? viewurl;
  final String? courseimage;
  final int? progress;
  final bool? hasprogress;
  final bool? isfavourite;
  final bool? hidden;
  final bool? showshortname;
  final String? coursecategory;

  const Course({
    this.id,
    this.fullname,
    this.shortname,
    this.idnumber,
    this.summary,
    this.summaryformat,
    this.startdate,
    this.enddate,
    this.visible,
    this.showactivitydates,
    this.showcompletionconditions,
    this.pdfexportfont,
    this.fullnamedisplay,
    this.viewurl,
    this.courseimage,
    this.progress,
    this.hasprogress,
    this.isfavourite,
    this.hidden,
    this.showshortname,
    this.coursecategory,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return _$CourseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CourseToJson(this);

  Course copyWith({
    int? id,
    String? fullname,
    String? shortname,
    String? idnumber,
    String? summary,
    int? summaryformat,
    int? startdate,
    int? enddate,
    bool? visible,
    bool? showactivitydates,
    bool? showcompletionconditions,
    String? pdfexportfont,
    String? fullnamedisplay,
    String? viewurl,
    String? courseimage,
    int? progress,
    bool? hasprogress,
    bool? isfavourite,
    bool? hidden,
    bool? showshortname,
    String? coursecategory,
  }) {
    return Course(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      shortname: shortname ?? this.shortname,
      idnumber: idnumber ?? this.idnumber,
      summary: summary ?? this.summary,
      summaryformat: summaryformat ?? this.summaryformat,
      startdate: startdate ?? this.startdate,
      enddate: enddate ?? this.enddate,
      visible: visible ?? this.visible,
      showactivitydates: showactivitydates ?? this.showactivitydates,
      showcompletionconditions:
          showcompletionconditions ?? this.showcompletionconditions,
      pdfexportfont: pdfexportfont ?? this.pdfexportfont,
      fullnamedisplay: fullnamedisplay ?? this.fullnamedisplay,
      viewurl: viewurl ?? this.viewurl,
      courseimage: courseimage ?? this.courseimage,
      progress: progress ?? this.progress,
      hasprogress: hasprogress ?? this.hasprogress,
      isfavourite: isfavourite ?? this.isfavourite,
      hidden: hidden ?? this.hidden,
      showshortname: showshortname ?? this.showshortname,
      coursecategory: coursecategory ?? this.coursecategory,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      fullname,
      shortname,
      idnumber,
      summary,
      summaryformat,
      startdate,
      enddate,
      visible,
      showactivitydates,
      showcompletionconditions,
      pdfexportfont,
      fullnamedisplay,
      viewurl,
      courseimage,
      progress,
      hasprogress,
      isfavourite,
      hidden,
      showshortname,
      coursecategory,
    ];
  }
}
