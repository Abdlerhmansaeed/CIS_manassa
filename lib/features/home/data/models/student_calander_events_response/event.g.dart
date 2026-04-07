// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  description: json['description'] as String?,
  descriptionformat: (json['descriptionformat'] as num?)?.toInt(),
  location: json['location'] as String?,
  categoryid: json['categoryid'],
  groupid: json['groupid'],
  userid: (json['userid'] as num?)?.toInt(),
  repeatid: json['repeatid'],
  eventcount: json['eventcount'],
  component: json['component'] as String?,
  modulename: json['modulename'] as String?,
  activityname: json['activityname'] as String?,
  activitystr: json['activitystr'] as String?,
  instance: (json['instance'] as num?)?.toInt(),
  eventtype: json['eventtype'] as String?,
  timestart: (json['timestart'] as num?)?.toInt(),
  timeduration: (json['timeduration'] as num?)?.toInt(),
  timesort: (json['timesort'] as num?)?.toInt(),
  timeusermidnight: (json['timeusermidnight'] as num?)?.toInt(),
  visible: (json['visible'] as num?)?.toInt(),
  timemodified: (json['timemodified'] as num?)?.toInt(),
  overdue: json['overdue'] as bool?,
  icon: json['icon'] == null
      ? null
      : Icon.fromJson(json['icon'] as Map<String, dynamic>),
  course: json['course'] == null
      ? null
      : Course.fromJson(json['course'] as Map<String, dynamic>),
  subscription: json['subscription'] == null
      ? null
      : Subscription.fromJson(json['subscription'] as Map<String, dynamic>),
  canedit: json['canedit'] as bool?,
  candelete: json['candelete'] as bool?,
  deleteurl: json['deleteurl'] as String?,
  editurl: json['editurl'] as String?,
  viewurl: json['viewurl'] as String?,
  formattedtime: json['formattedtime'] as String?,
  formattedlocation: json['formattedlocation'] as String?,
  isactionevent: json['isactionevent'] as bool?,
  iscourseevent: json['iscourseevent'] as bool?,
  iscategoryevent: json['iscategoryevent'] as bool?,
  groupname: json['groupname'],
  normalisedeventtype: json['normalisedeventtype'] as String?,
  normalisedeventtypetext: json['normalisedeventtypetext'] as String?,
  action: json['action'] == null
      ? null
      : Action.fromJson(json['action'] as Map<String, dynamic>),
  purpose: json['purpose'] as String?,
  branded: json['branded'] as bool?,
  url: json['url'] as String?,
);

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'descriptionformat': instance.descriptionformat,
  'location': instance.location,
  'categoryid': instance.categoryid,
  'groupid': instance.groupid,
  'userid': instance.userid,
  'repeatid': instance.repeatid,
  'eventcount': instance.eventcount,
  'component': instance.component,
  'modulename': instance.modulename,
  'activityname': instance.activityname,
  'activitystr': instance.activitystr,
  'instance': instance.instance,
  'eventtype': instance.eventtype,
  'timestart': instance.timestart,
  'timeduration': instance.timeduration,
  'timesort': instance.timesort,
  'timeusermidnight': instance.timeusermidnight,
  'visible': instance.visible,
  'timemodified': instance.timemodified,
  'overdue': instance.overdue,
  'icon': instance.icon,
  'course': instance.course,
  'subscription': instance.subscription,
  'canedit': instance.canedit,
  'candelete': instance.candelete,
  'deleteurl': instance.deleteurl,
  'editurl': instance.editurl,
  'viewurl': instance.viewurl,
  'formattedtime': instance.formattedtime,
  'formattedlocation': instance.formattedlocation,
  'isactionevent': instance.isactionevent,
  'iscourseevent': instance.iscourseevent,
  'iscategoryevent': instance.iscategoryevent,
  'groupname': instance.groupname,
  'normalisedeventtype': instance.normalisedeventtype,
  'normalisedeventtypetext': instance.normalisedeventtypetext,
  'action': instance.action,
  'purpose': instance.purpose,
  'branded': instance.branded,
  'url': instance.url,
};
