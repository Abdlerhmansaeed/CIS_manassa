import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mansaa_app/features/academic_schedule/data/models/schedule_item_model.dart';

part 'cached_schedule_model.g.dart';

@JsonSerializable()
class CachedScheduleModel extends Equatable {
  final List<ScheduleItemModel> scheduleItems;
  final DateTime cachedAt;

  const CachedScheduleModel({
    required this.scheduleItems,
    required this.cachedAt,
  });

  factory CachedScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$CachedScheduleModelFromJson(json);

  Map<String, dynamic> toJson() => _$CachedScheduleModelToJson(this);

  bool get isExpired =>
      DateTime.now().difference(cachedAt).inDays >= 7;

  @override
  List<Object?> get props => [scheduleItems, cachedAt];
}
