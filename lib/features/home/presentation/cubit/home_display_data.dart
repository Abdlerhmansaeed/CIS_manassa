import 'package:flutter/material.dart';
import 'package:mansaa_app/features/home/data/models/student_calander_events_response/event.dart';

/// A view-model that holds all pre-computed display data for the Home Dashboard.
/// Produced once by [HomeCubit] after a successful API response, so that
/// widgets remain pure renderers with zero business logic.
class HomeDisplayData {
  final int overdueCount;
  final int upcomingCount;
  final Event? topUrgentEvent;

  /// Events grouped AND pre-formatted into labelled buckets.
  /// Empty groups are excluded.
  final Map<String, List<TaskDisplayData>> groupedEvents;

  /// Per-weekday dot colours derived from events (max 3 per day).
  final List<WeekDayData> weekDays;

  /// Display label for the current month, e.g. "Apr".
  final String monthLabel;

  const HomeDisplayData({
    required this.overdueCount,
    required this.upcomingCount,
    required this.topUrgentEvent,
    required this.groupedEvents,
    required this.weekDays,
    required this.monthLabel,
  });
}

/// Represents a single day column in the horizontal weekly calendar.
class WeekDayData {
  final String label; // "Mon", "Tue", …
  final String dateNumber; // "6", "7", …
  final bool isToday;
  final List<Color> dots; // event indicator colours (max 3)

  const WeekDayData({
    required this.label,
    required this.dateNumber,
    required this.isToday,
    required this.dots,
  });
}

/// Classifies the type of a calendar event for display purposes.
enum EventType { assignment, quiz, other }

/// A pre-formatted snapshot of one [Event] for display in [TaskItemWidget].
/// All string assembly, type detection, and button-visibility logic is
/// computed by [HomeCubit] — the widget only renders.
class TaskDisplayData {
  final String title;
  final String courseName;
  final String typeLabel;
  final String timeText; // e.g. "11:59 PM" or ""
  final bool isOverdue;
  final EventType eventType;

  /// Whether the action button should be shown.
  /// - Assignment: always true when action exists.
  /// - Quiz: only true when the quiz start time has arrived.
  final bool showAction;

  /// Specific timing for Quizzes (Starts at ... ends at ...)
  final String? startTimeText;
  final String? endTimeText;
  final bool isStarted;

  /// Whether the task is currently actionable according to the API.
  final bool isActionable;

  final Event event; // kept solely for the actionable button URL

  const TaskDisplayData({
    required this.title,
    required this.courseName,
    required this.typeLabel,
    required this.timeText,
    required this.isOverdue,
    required this.eventType,
    required this.showAction,
    required this.isActionable,
    required this.isStarted,
    this.startTimeText,
    this.endTimeText,
    required this.event,
  });
}
