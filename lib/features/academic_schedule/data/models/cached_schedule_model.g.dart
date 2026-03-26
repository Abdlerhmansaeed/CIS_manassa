// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CachedScheduleModel _$CachedScheduleModelFromJson(Map<String, dynamic> json) =>
    CachedScheduleModel(
      scheduleItems: (json['scheduleItems'] as List<dynamic>)
          .map((e) => ScheduleItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      cachedAt: DateTime.parse(json['cachedAt'] as String),
    );

Map<String, dynamic> _$CachedScheduleModelToJson(
  CachedScheduleModel instance,
) => <String, dynamic>{
  'scheduleItems': instance.scheduleItems,
  'cachedAt': instance.cachedAt.toIso8601String(),
};
