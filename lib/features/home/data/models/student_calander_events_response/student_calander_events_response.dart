import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'event.dart';

part 'student_calander_events_response.g.dart';

@JsonSerializable()
class StudentCalanderEventsResponse extends Equatable {
  final List<Event>? events;
  final int? firstid;
  final int? lastid;

  const StudentCalanderEventsResponse({this.events, this.firstid, this.lastid});

  factory StudentCalanderEventsResponse.fromJson(Map<String, dynamic> json) {
    return _$StudentCalanderEventsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$StudentCalanderEventsResponseToJson(this);

  StudentCalanderEventsResponse copyWith({
    List<Event>? events,
    int? firstid,
    int? lastid,
  }) {
    return StudentCalanderEventsResponse(
      events: events ?? this.events,
      firstid: firstid ?? this.firstid,
      lastid: lastid ?? this.lastid,
    );
  }

  @override
  List<Object?> get props => [events, firstid, lastid];
}
