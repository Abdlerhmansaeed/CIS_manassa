import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'action.dart';
import 'course.dart';
import 'icon.dart';
import 'subscription.dart';

part 'event.g.dart';

@JsonSerializable()
class Event extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final int? descriptionformat;
  final String? location;
  final dynamic categoryid;
  final dynamic groupid;
  final int? userid;
  final dynamic repeatid;
  final dynamic eventcount;
  final String? component;
  final String? modulename;
  final String? activityname;
  final String? activitystr;
  final int? instance;
  final String? eventtype;
  final int? timestart;
  final int? timeduration;
  final int? timesort;
  final int? timeusermidnight;
  final int? visible;
  final int? timemodified;
  final bool? overdue;
  final Icon? icon;
  final Course? course;
  final Subscription? subscription;
  final bool? canedit;
  final bool? candelete;
  final String? deleteurl;
  final String? editurl;
  final String? viewurl;
  final String? formattedtime;
  final String? formattedlocation;
  final bool? isactionevent;
  final bool? iscourseevent;
  final bool? iscategoryevent;
  final dynamic groupname;
  final String? normalisedeventtype;
  final String? normalisedeventtypetext;
  final Action? action;
  final String? purpose;
  final bool? branded;
  final String? url;

  const Event({
    this.id,
    this.name,
    this.description,
    this.descriptionformat,
    this.location,
    this.categoryid,
    this.groupid,
    this.userid,
    this.repeatid,
    this.eventcount,
    this.component,
    this.modulename,
    this.activityname,
    this.activitystr,
    this.instance,
    this.eventtype,
    this.timestart,
    this.timeduration,
    this.timesort,
    this.timeusermidnight,
    this.visible,
    this.timemodified,
    this.overdue,
    this.icon,
    this.course,
    this.subscription,
    this.canedit,
    this.candelete,
    this.deleteurl,
    this.editurl,
    this.viewurl,
    this.formattedtime,
    this.formattedlocation,
    this.isactionevent,
    this.iscourseevent,
    this.iscategoryevent,
    this.groupname,
    this.normalisedeventtype,
    this.normalisedeventtypetext,
    this.action,
    this.purpose,
    this.branded,
    this.url,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);

  Event copyWith({
    int? id,
    String? name,
    String? description,
    int? descriptionformat,
    String? location,
    dynamic categoryid,
    dynamic groupid,
    int? userid,
    dynamic repeatid,
    dynamic eventcount,
    String? component,
    String? modulename,
    String? activityname,
    String? activitystr,
    int? instance,
    String? eventtype,
    int? timestart,
    int? timeduration,
    int? timesort,
    int? timeusermidnight,
    int? visible,
    int? timemodified,
    bool? overdue,
    Icon? icon,
    Course? course,
    Subscription? subscription,
    bool? canedit,
    bool? candelete,
    String? deleteurl,
    String? editurl,
    String? viewurl,
    String? formattedtime,
    String? formattedlocation,
    bool? isactionevent,
    bool? iscourseevent,
    bool? iscategoryevent,
    dynamic groupname,
    String? normalisedeventtype,
    String? normalisedeventtypetext,
    Action? action,
    String? purpose,
    bool? branded,
    String? url,
  }) {
    return Event(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      descriptionformat: descriptionformat ?? this.descriptionformat,
      location: location ?? this.location,
      categoryid: categoryid ?? this.categoryid,
      groupid: groupid ?? this.groupid,
      userid: userid ?? this.userid,
      repeatid: repeatid ?? this.repeatid,
      eventcount: eventcount ?? this.eventcount,
      component: component ?? this.component,
      modulename: modulename ?? this.modulename,
      activityname: activityname ?? this.activityname,
      activitystr: activitystr ?? this.activitystr,
      instance: instance ?? this.instance,
      eventtype: eventtype ?? this.eventtype,
      timestart: timestart ?? this.timestart,
      timeduration: timeduration ?? this.timeduration,
      timesort: timesort ?? this.timesort,
      timeusermidnight: timeusermidnight ?? this.timeusermidnight,
      visible: visible ?? this.visible,
      timemodified: timemodified ?? this.timemodified,
      overdue: overdue ?? this.overdue,
      icon: icon ?? this.icon,
      course: course ?? this.course,
      subscription: subscription ?? this.subscription,
      canedit: canedit ?? this.canedit,
      candelete: candelete ?? this.candelete,
      deleteurl: deleteurl ?? this.deleteurl,
      editurl: editurl ?? this.editurl,
      viewurl: viewurl ?? this.viewurl,
      formattedtime: formattedtime ?? this.formattedtime,
      formattedlocation: formattedlocation ?? this.formattedlocation,
      isactionevent: isactionevent ?? this.isactionevent,
      iscourseevent: iscourseevent ?? this.iscourseevent,
      iscategoryevent: iscategoryevent ?? this.iscategoryevent,
      groupname: groupname ?? this.groupname,
      normalisedeventtype: normalisedeventtype ?? this.normalisedeventtype,
      normalisedeventtypetext:
          normalisedeventtypetext ?? this.normalisedeventtypetext,
      action: action ?? this.action,
      purpose: purpose ?? this.purpose,
      branded: branded ?? this.branded,
      url: url ?? this.url,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      description,
      descriptionformat,
      location,
      categoryid,
      groupid,
      userid,
      repeatid,
      eventcount,
      component,
      modulename,
      activityname,
      activitystr,
      instance,
      eventtype,
      timestart,
      timeduration,
      timesort,
      timeusermidnight,
      visible,
      timemodified,
      overdue,
      icon,
      course,
      subscription,
      canedit,
      candelete,
      deleteurl,
      editurl,
      viewurl,
      formattedtime,
      formattedlocation,
      isactionevent,
      iscourseevent,
      iscategoryevent,
      groupname,
      normalisedeventtype,
      normalisedeventtypetext,
      action,
      purpose,
      branded,
      url,
    ];
  }
}
