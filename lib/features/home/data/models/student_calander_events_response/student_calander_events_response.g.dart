// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_calander_events_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentCalanderEventsResponse _$StudentCalanderEventsResponseFromJson(
  Map<String, dynamic> json,
) => StudentCalanderEventsResponse(
  events: (json['events'] as List<dynamic>?)
      ?.map((e) => Event.fromJson(e as Map<String, dynamic>))
      .toList(),
  firstid: (json['firstid'] as num?)?.toInt(),
  lastid: (json['lastid'] as num?)?.toInt(),
);

Map<String, dynamic> _$StudentCalanderEventsResponseToJson(
  StudentCalanderEventsResponse instance,
) => <String, dynamic>{
  'events': instance.events,
  'firstid': instance.firstid,
  'lastid': instance.lastid,
};
