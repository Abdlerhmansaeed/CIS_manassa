// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleItemModel _$ScheduleItemModelFromJson(Map<String, dynamic> json) =>
    ScheduleItemModel(
      subjectCode: json['subjectCode'] as String?,
      subjectName: json['subjectName'] as String?,
      groupNumber: json['groupNumber'] as String?,
      type: json['type'] as String?,
      day: json['day'] as String?,
      period: json['period'] as String?,
      place: json['place'] as String?,
      doctor: json['doctor'] as String?,
    );

Map<String, dynamic> _$ScheduleItemModelToJson(ScheduleItemModel instance) =>
    <String, dynamic>{
      'subjectCode': instance.subjectCode,
      'subjectName': instance.subjectName,
      'groupNumber': instance.groupNumber,
      'type': instance.type,
      'day': instance.day,
      'period': instance.period,
      'place': instance.place,
      'doctor': instance.doctor,
    };
