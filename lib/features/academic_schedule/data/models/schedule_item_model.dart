import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule_item_model.g.dart';

@JsonSerializable()
class ScheduleItemModel extends Equatable {
  final String? subjectCode;
  final String? subjectName;
  final String? groupNumber;
  final String? type;
  final String? day;
  final String? period;
  final String? place;
  final String? doctor;

  const ScheduleItemModel({
    this.subjectCode,
    this.subjectName,
    this.groupNumber,
    this.type,
    this.day,
    this.period,
    this.place,
    this.doctor,
  });

  factory ScheduleItemModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleItemModelToJson(this);

  /// Parses schedule items from the raw HTML returned by the CIS services portal.
  static List<ScheduleItemModel> fromHtml(String html) {
    final bs = BeautifulSoup(html);
    final htmlRaws = bs.findAll("tr");
    final scheduleItems = <ScheduleItemModel>[];

    // بنبدأ من 1 عشان نتجاهل صف العناوين (Headers)
    for (var i = 1; i < htmlRaws.length; i++) {
      final htmlRaw = htmlRaws[i];
      final cells = htmlRaw.findAll("td");

      // التعديل هنا: نتأكد إن عدد الخلايا 8 أو أكتر (لأن في خلايا مخفية في الآخر)
      if (cells.length >= 8) {
        scheduleItems.add(
          ScheduleItemModel(
            subjectCode: cells[0].text.trim(),
            subjectName: cells[1].text.trim(),
            groupNumber: cells[2].text.trim(),
            type: cells[3].text.trim(),
            day: cells[4].text.trim(),
            // استخدمنا replaceAll عشان نشيل أي سطور فاضية (Enters) أو مسافات زيادة في وقت المحاضرة
            period: cells[5].text.trim().replaceAll(RegExp(r'\s+'), ' '),
            place: cells[6].text.trim(),
            doctor: cells[7].text.trim(),
          ),
        );
      }
    }
    return scheduleItems;
  }

  /// Returns the start time in minutes from the beginning of the day for sorting.
  int get startTimeMinutes {
    if (period == null || period!.isEmpty) return 0;
    try {
      final text = period!.toLowerCase();
      // Get the first part before '-' or 'الى'
      final timePart = text.split(RegExp(r'-|الى')).first.trim();

      // Extract numbers (supporting Arabic and Western numerals)
      final timeMatch = RegExp(r'(\d+|[٠-٩]+):(\d+|[٠-٩]+)').firstMatch(timePart);
      if (timeMatch == null) return 0;

      int hour = _parseArabicInt(timeMatch.group(1)!);
      int minute = _parseArabicInt(timeMatch.group(2)!);

      // AM/PM detection
      bool isPm = text.contains('ظهراً') ||
          text.contains('عصراً') ||
          text.contains('مساءً') ||
          text.contains('pm');

      // Special case: "12 PM" is 720, "12 AM" is 0. 
      // Most university schedules start from 8 or 9 AM.
      if (isPm && hour < 12) hour += 12;
      if (!isPm && hour == 12) hour = 0;

      return hour * 60 + minute;
    } catch (_) {
      return 0;
    }
  }

  int _parseArabicInt(String input) {
    const arabicToWestern = {
      '٠': '0',
      '١': '1',
      '٢': '2',
      '٣': '3',
      '٤': '4',
      '٥': '5',
      '٦': '6',
      '٧': '7',
      '٨': '8',
      '٩': '9',
    };
    final western = input.split('').map((c) => arabicToWestern[c] ?? c).join('');
    return int.tryParse(western) ?? 0;
  }

  @override
  List<Object?> get props => [
    subjectCode,
    subjectName,
    groupNumber,
    type,
    day,
    period,
    place,
    doctor,
  ];
}
