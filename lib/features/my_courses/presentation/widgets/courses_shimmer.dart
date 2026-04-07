import 'package:flutter/material.dart';
import 'package:resposive_xx/responsive/responsive.dart';

class CoursesShimmer extends StatefulWidget {
  const CoursesShimmer({super.key});

  @override
  State<CoursesShimmer> createState() => _CoursesShimmerState();
}

class _CoursesShimmerState extends State<CoursesShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
    _animation = Tween<double>(
      begin: 0.3,
      end: 0.7,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return Column(
          children: List.generate(
            3,
            (index) => Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: _ShimmerCard(opacity: _animation.value),
            ),
          ),
        );
      },
    );
  }
}

class _ShimmerCard extends StatelessWidget {
  final double opacity;

  const _ShimmerCard({required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header bar
          Container(
            height: 32.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: opacity),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shimmerBox(width: 180.w, height: 20.h, opacity: opacity),
                SizedBox(height: 8.h),
                _shimmerBox(width: 130.w, height: 14.h, opacity: opacity),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    _shimmerBox(width: 80.w, height: 24.h, opacity: opacity),
                    SizedBox(width: 8.w),
                    _shimmerBox(width: 70.w, height: 24.h, opacity: opacity),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _shimmerBox({
    required double width,
    required double height,
    required double opacity,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300]!.withValues(alpha: opacity),
        borderRadius: BorderRadius.circular(6.r),
      ),
    );
  }
}
