import 'package:flutter/material.dart';
import 'package:mansaa_app/core/helpers/date_helper.dart';
import 'package:mansaa_app/core/theme/app_colors.dart';
import 'package:mansaa_app/features/home/data/models/quizezs_response/quiz.dart';
import 'package:resposive_xx/responsive/responsive.dart';

class QuizDetailsBottomSheet extends StatelessWidget {
  final Quiz quiz;
  const QuizDetailsBottomSheet({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- 1. Drag Handle ---
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  margin: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD1C4BC),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),

              // --- 2. Header Section ---
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 56.w,
                    height: 56.w,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.05),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.timer,
                        color: AppColors.primary,
                        size: 28.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primary),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            "QUIZ",
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          quiz.name ?? 'اختبار',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.onSurface,
                          ),
                        ),
                        if (quiz.course != null) ...[
                          SizedBox(height: 4.h),
                          Text(
                            "رقم الدورة: ${quiz.course}",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // --- 3. Deadline Card ---
              if (quiz.timeclose != null && quiz.timeclose! > 0)
                Container(
                  margin: EdgeInsets.only(bottom: 24.h),
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF5F5),
                    borderRadius: BorderRadius.circular(16.r),
                    border: const Border(
                      right: BorderSide(color: AppColors.primary, width: 3.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        offset: const Offset(0, 8),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                color: AppColors.primary,
                                size: 20.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "تاريخ الإغلاق",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            DateHelper.formatEpochToString(quiz.timeclose),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: AppColors.onSurfaceVariant,
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            DateHelper.formatEpochToFullDate(quiz.timeclose),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              // --- 4. Quiz Info Chips Row ---
              Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children: [
                  _InfoChip(
                    icon: Icons.hourglass_empty,
                    label: _formatDuration(quiz.timelimit),
                    bgColor: Colors.amber.shade50,
                    textColor: Colors.amber.shade800,
                  ),
                  _InfoChip(
                    icon: Icons.replay,
                    label: _formatAttempts(quiz.attempts),
                    bgColor: Colors.blue.shade50,
                    textColor: Colors.blue.shade800,
                  ),
                  _InfoChip(
                    icon: Icons.quiz,
                    label: quiz.hasfeedback == 1
                        ? "يوجد تقييم"
                        : "أسئلة متعددة",
                    bgColor: Colors.grey.shade100,
                    textColor: Colors.grey.shade700,
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // --- 5. Warning Banner ---
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("⚠️", style: TextStyle(fontSize: 20.sp)),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        "تأكد من استقرار اتصالك بالإنترنت. بمجرد الدخول سيبدأ مؤقت الاختبار تلقائياً.",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.amber.shade900,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),

              // --- 6. Action Section ---
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(12.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "بدء الاختبار الآن",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(Icons.arrow_back, size: 20.sp),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(12.r),

                        foregroundColor: AppColors.onSurfaceVariant,
                      ),
                      child: Text(
                        "إغلاق",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDuration(int? limitSeconds) {
    if (limitSeconds == null || limitSeconds == 0) return "مفتوح المدة";
    final minutes = limitSeconds ~/ 60;
    return "مدة: $minutes دقيقة";
  }

  String _formatAttempts(int? attempts) {
    if (attempts == null || attempts == 0) return "محاولات مفتوحة";
    if (attempts == 1) return "محاولة واحدة";
    return "$attempts محاولات";
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color bgColor;
  final Color textColor;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18.sp, color: textColor),
          SizedBox(width: 8.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
