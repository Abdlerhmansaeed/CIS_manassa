import 'package:flutter/material.dart';
import 'package:mansaa_app/core/helpers/date_helper.dart';
import 'package:mansaa_app/core/theme/app_colors.dart';
import 'package:mansaa_app/features/home/data/models/student_calander_events_response/event.dart';
import 'package:mansaa_app/features/home/presentation/cubit/home_display_data.dart';
import 'package:mansaa_app/core/extensions/theme_extension.dart';

class HomeEventsMapper {
  /// Maps a raw list of [Event] models to the [HomeDisplayData] view model.
  static HomeDisplayData mapToDisplayData(List<Event> events) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(Duration(days: 1));
    final nextWeekEnd = today.add(Duration(days: 8));

    // --- Aggregate counts & top urgent event ---
    int overdueCount = 0;
    int upcomingCount = 0;
    Event? topUrgentEvent;

    for (final event in events) {
      if (event.overdue == true) {
        overdueCount++;
        topUrgentEvent ??= event;
      } else if (event.timestart != null) {
        final date = DateTime.fromMillisecondsSinceEpoch(
          event.timestart! * 1000,
        );
        if (date.isAfter(now)) {
          upcomingCount++;
          if (topUrgentEvent == null && date.difference(now).inDays <= 1) {
            topUrgentEvent = event;
          }
        }
      }
    }

    // --- Group events by time bucket ---
    final Map<String, List<TaskDisplayData>> groupedEvents = {
      'Today': [],
      'Tomorrow': [],
      'Next Week': [],
      'Later': [],
    };

    // Pre-group quizzes by instance ID to find open/close pairs
    final Map<int, List<Event>> quizGroups = {};
    for (final event in events.where((e) => e.modulename == 'quiz')) {
      if (event.instance != null) {
        quizGroups.putIfAbsent(event.instance!, () => []).add(event);
      }
    }

    final Set<int> processedQuizInstances = {};

    for (final event in events) {
      if (event.timestart == null) continue;

      TaskDisplayData? taskData;

      if (event.modulename == 'quiz' && event.instance != null) {
        if (processedQuizInstances.contains(event.instance)) continue;
        processedQuizInstances.add(event.instance!);
        taskData = toTaskDisplayData(event, quizGroups[event.instance]);
      } else if (event.modulename != 'quiz') {
        taskData = toTaskDisplayData(event);
      }

      if (taskData == null) continue;

      final date = DateTime.fromMillisecondsSinceEpoch(event.timestart! * 1000);
      final eventDay = DateTime(date.year, date.month, date.day);

      if (eventDay == today) {
        groupedEvents['Today']!.add(taskData);
      } else if (eventDay == tomorrow) {
        groupedEvents['Tomorrow']!.add(taskData);
      } else if (eventDay.isAfter(tomorrow) && eventDay.isBefore(nextWeekEnd)) {
        groupedEvents['Next Week']!.add(taskData);
      } else {
        groupedEvents['Later']!.add(taskData);
      }
    }
    groupedEvents.removeWhere((_, v) => v.isEmpty);

    // --- Build weekly calendar row ---
    final firstDayOfWeek = today.subtract(Duration(days: today.weekday - 1));
    final List<WeekDayData> weekDays = List.generate(7, (index) {
      final date = firstDayOfWeek.add(Duration(days: index));
      final isToday = date == today;
      final dots = <Color>[];

      for (final event in events) {
        if (event.timestart == null) continue;
        final eDate = DateTime.fromMillisecondsSinceEpoch(
          event.timestart! * 1000,
        );
        if (eDate.year == date.year &&
            eDate.month == date.month &&
            eDate.day == date.day) {
          dots.add(event.overdue == true ? AppColors.error : AppColors.primary);
          if (dots.length == 3) break; // cap at 3 dots
        }
      }

      return WeekDayData(
        label: DateHelper.getShortDayName(date.weekday),
        dateNumber: date.day.toString(),
        isToday: isToday,
        dots: dots,
      );
    });

    return HomeDisplayData(
      overdueCount: overdueCount,
      upcomingCount: upcomingCount,
      topUrgentEvent: topUrgentEvent,
      groupedEvents: groupedEvents,
      weekDays: weekDays,
      monthLabel: DateHelper.getShortMonthName(now.month),
    );
  }

  /// Converts a raw [Event] into a pre-formatted [TaskDisplayData].
  static TaskDisplayData toTaskDisplayData(
    Event event, [
    List<Event>? instanceEvents,
  ]) {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    // --- Classify event type ---
    final EventType eventType = switch (event.modulename) {
      'assign' => EventType.assignment,
      'quiz' => EventType.quiz,
      _ => EventType.other,
    };

    // --- Quiz Range Logic ---
    int? startTime;
    int? endTime;
    bool isStarted = true;

    if (eventType == EventType.quiz &&
        instanceEvents != null &&
        instanceEvents.isNotEmpty) {
      // Find open and close events
      final openEvent = instanceEvents.firstWhere(
        (e) => e.eventtype == 'open',
        orElse: () => instanceEvents.reduce(
          (a, b) => (a.timestart ?? 0) < (b.timestart ?? 0) ? a : b,
        ),
      );
      final closeEvent = instanceEvents.firstWhere(
        (e) => e.eventtype == 'close',
        orElse: () => instanceEvents.reduce(
          (a, b) => (a.timestart ?? 0) > (b.timestart ?? 0) ? a : b,
        ),
      );

      startTime = openEvent.timestart;
      endTime = closeEvent.timestart;

      // Quiz is started if now is past opening time
      isStarted = startTime != null && now >= startTime;
    } else {
      // For assignments, just use timestart as the "deadline"
      endTime = event.timestart;
    }

    final startTimeText = DateHelper.formatEpochToString(startTime);
    final endTimeText = DateHelper.formatEpochToString(endTime);

    // --- Decide whether to show the action button ---
    final bool hasAction = event.action != null && event.action!.name != null;
    final bool isActionable = event.action?.actionable ?? false;
    final bool showAction =
        hasAction && (eventType == EventType.quiz ? isStarted : true);

    return TaskDisplayData(
      title: event.name ?? event.activityname ?? 'No Title',
      courseName: event.course?.fullname ?? '',
      typeLabel: event.activitystr ?? 'Task',
      timeText: endTimeText, // Keep legacy timeText for backward compatibility
      startTimeText: startTimeText,
      endTimeText: endTimeText,
      isOverdue: event.overdue == true,
      eventType: eventType,
      showAction: showAction,
      isActionable: isActionable,
      isStarted: isStarted,
      event: event,
    );
  }
}
