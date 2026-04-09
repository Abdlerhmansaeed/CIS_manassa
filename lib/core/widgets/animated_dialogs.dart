/// Animated Dialogs with Lottie animations for Fitness App
///
/// Provides beautiful success and failure dialogs with:
/// - Lottie animations with completion callbacks
/// - Error handling for invalid animations
/// - Fallback icons when animations fail
/// - Responsive design integration
/// - BuildContext extensions for easy usage

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mansaa_app/core/constants/app_constants.dart';
import 'package:mansaa_app/core/extensions/theme_extension.dart';
import 'package:resposive_xx/responsive/responsive_extensions.dart';
import 'package:mansaa_app/core/theme/app_colors.dart';

/// Callback function type for animation completion
typedef AnimationCallback = void Function();

/// Callback function type for button actions
typedef ButtonCallback = void Function();

/// Dialog size presets
enum DialogSize { small, medium, large, custom }

/// Animation style presets
enum AnimationStyle { elastic, bounce, fade, scale, slide }

/// Customization class for dialog appearance
class DialogCustomization {
  final Color? backgroundColor;
  final Color? primaryColor;
  final Color? buttonColor;
  final Color? titleColor;
  final Color? messageColor;
  final Color? barrierColor;

  final double? borderRadius;
  final double? elevation;
  final List<BoxShadow>? customShadows;

  final double? titleFontSize;
  final double? messageFontSize;
  final FontWeight? titleFontWeight;
  final FontWeight? messageFontWeight;
  final String? fontFamily;

  final double? animationSize;
  final EdgeInsets? contentPadding;
  final EdgeInsets? buttonPadding;
  final EdgeInsets? dialogMargin;

  final double? buttonHeight;
  final double? buttonBorderRadius;
  final Color? buttonTextColor;
  final double? buttonFontSize;

  final Duration? animationDuration;
  final Duration? fadeAnimationDuration;
  final Curve? animationCurve;
  final Curve? fadeAnimationCurve;

  final DialogSize dialogSize;
  final AnimationStyle animationStyle;
  final Size? customSize;

  final bool enableHapticFeedback;
  final bool enableSoundEffects;
  final int? maxTitleLines;
  final int? maxMessageLines;
  final TextOverflow? textOverflow;

  const DialogCustomization({
    this.backgroundColor,
    this.primaryColor,
    this.buttonColor,
    this.titleColor,
    this.messageColor,
    this.barrierColor,
    this.borderRadius,
    this.elevation,
    this.customShadows,
    this.titleFontSize,
    this.messageFontSize,
    this.titleFontWeight,
    this.messageFontWeight,
    this.fontFamily,
    this.animationSize,
    this.contentPadding,
    this.buttonPadding,
    this.dialogMargin,
    this.buttonHeight,
    this.buttonBorderRadius,
    this.buttonTextColor,
    this.buttonFontSize,
    this.animationDuration,
    this.fadeAnimationDuration,
    this.animationCurve,
    this.fadeAnimationCurve,
    this.dialogSize = DialogSize.medium,
    this.animationStyle = AnimationStyle.elastic,
    this.customSize,
    this.enableHapticFeedback = true,
    this.enableSoundEffects = false,
    this.maxTitleLines,
    this.maxMessageLines,
    this.textOverflow,
  });

  static const DialogCustomization success = DialogCustomization(
    primaryColor: AppColors.primary,
    buttonColor: AppColors.primary,
    dialogSize: DialogSize.medium,
    animationStyle: AnimationStyle.elastic,
  );

  static const DialogCustomization failure = DialogCustomization(
    primaryColor: Colors.redAccent,
    buttonColor: Colors.redAccent,
    dialogSize: DialogSize.medium,
    animationStyle: AnimationStyle.bounce,
  );
}

abstract class BaseAnimatedDialog extends StatefulWidget {
  const BaseAnimatedDialog({
    super.key,
    required this.title,
    this.message,
    required this.animationPath,
    this.showButton = false,
    this.buttonText,
    this.onButtonPressed,
    this.onAnimationComplete,
    this.autoDismiss = true,
    this.dismissDelay = const Duration(seconds: 2),
    this.barrierDismissible = true,
    this.customization = const DialogCustomization(),
    this.lottieRepeat = false,
    this.lottieReverse = false,
    this.customWidget,
    this.secondaryButton = false,
    this.secondaryButtonText,
    this.onSecondaryButtonPressed,
  });

  final String title;
  final String? message;
  final String animationPath;
  final bool showButton;
  final String? buttonText;
  final ButtonCallback? onButtonPressed;
  final AnimationCallback? onAnimationComplete;
  final bool autoDismiss;
  final Duration dismissDelay;
  final bool barrierDismissible;
  final DialogCustomization customization;
  final bool lottieRepeat;
  final bool lottieReverse;
  final Widget? customWidget;
  final bool secondaryButton;
  final String? secondaryButtonText;
  final ButtonCallback? onSecondaryButtonPressed;
}

abstract class BaseAnimatedDialogState<T extends BaseAnimatedDialog>
    extends State<T>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startEntryAnimation();

    if (widget.autoDismiss && !widget.showButton) {
      _scheduleAutoDismiss();
    }
  }

  void _initializeAnimations() {
    _scaleController = AnimationController(
      duration: widget.customization.animationDuration ?? const Duration(milliseconds: 400),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: widget.customization.fadeAnimationDuration ?? const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(parent: _scaleController, curve: _getAnimationCurve());
    _fadeAnimation = CurvedAnimation(parent: _fadeController, curve: widget.customization.fadeAnimationCurve ?? Curves.easeInOut);
  }

  Curve _getAnimationCurve() {
    switch (widget.customization.animationStyle) {
      case AnimationStyle.elastic: return Curves.elasticOut;
      case AnimationStyle.bounce: return Curves.bounceOut;
      case AnimationStyle.fade: return Curves.easeInOut;
      case AnimationStyle.scale: return Curves.fastOutSlowIn;
      case AnimationStyle.slide: return Curves.easeOutCubic;
    }
  }

  void _startEntryAnimation() {
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _scaleController.forward();
    });
  }

  void _scheduleAutoDismiss() async {
    Future.delayed(widget.dismissDelay, () {
      if (mounted) _dismissDialog();
    });
  }

  Future<void> _dismissDialog() async {
    await _scaleController.reverse().then((_) {
      _fadeController.reverse().then((_) {
        if (mounted) Navigator.of(context).pop();
      });
    });
  }

  void _onButtonPressed() async {
    widget.onButtonPressed?.call();
    if (widget.onButtonPressed == null) await _dismissDialog();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  Color get primaryColor;
  Color get backgroundColor;
  Color get buttonColor;

  Size _getDialogSize() {
    switch (widget.customization.dialogSize) {
      case DialogSize.small:
        return Size(240.w, 240.h);
      case DialogSize.medium:
        return Size(280.w, 280.h);
      case DialogSize.large:
        return Size(320.w, 320.h);
      default:
        return Size(280.w, 280.h);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dialogSize = _getDialogSize();
    final customization = widget.customization;

    return Material(
      type: MaterialType.transparency,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              margin: customization.dialogMargin ?? const EdgeInsets.symmetric(horizontal: 24),
              width: dialogSize.width,
              height: dialogSize.height,
              decoration: BoxDecoration(
                color: customization.backgroundColor ?? backgroundColor,
                borderRadius: BorderRadius.circular(customization.borderRadius ?? 20.r),
                boxShadow: customization.customShadows ?? [
                  BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 20.r, offset: Offset(0, 10.h)),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildAnimationSection(),
                  _buildContentSection(),
                  if (widget.customWidget != null) widget.customWidget!,
                  if (widget.showButton) _buildButtonSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimationSection() {
    final customization = widget.customization;
    final animationSize = customization.animationSize ?? 100;

    return SizedBox(
      width: animationSize.w,
      height: animationSize.h,
      child: Lottie.asset(
        widget.animationPath,
        fit: BoxFit.contain,
        repeat: widget.lottieRepeat,
        reverse: widget.lottieReverse,
        errorBuilder: (context, error, stackTrace) {
          // Fallback icon if animation fails
          return Icon(
            widget is SuccessDialog ? Icons.check_circle_outline : Icons.error_outline,
            size: animationSize.r,
            color: primaryColor,
          );
        },
        onLoaded: (composition) {
          // If duration is 0, skip delay or pop immediately if autoDismiss
          if (composition.duration.inMilliseconds > 0) {
            Future.delayed(composition.duration, () {
              if (mounted) widget.onAnimationComplete?.call();
            });
          } else {
             widget.onAnimationComplete?.call();
          }
        },
      ),
    );
  }

  Widget _buildContentSection() {
    final customization = widget.customization;
    return Padding(
      padding: customization.contentPadding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: customization.titleFontSize ?? 18.sp,
              fontWeight: FontWeight.bold,
              color: customization.titleColor ?? primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          if (widget.message != null) ...[
            SizedBox(height: 8.h),
            Text(
              widget.message!,
              style: TextStyle(fontSize: 14.sp, color: context.colors.onSurfaceVariant.withOpacity(0.7)),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildButtonSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SizedBox(
        width: double.infinity,
        height: 48.h,
        child: ElevatedButton(
          onPressed: _onButtonPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          ),
          child: Text(widget.buttonText ?? 'OK', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

class SuccessDialog extends BaseAnimatedDialog {
  const SuccessDialog({
    super.key,
    required super.title,
    super.message,
    super.showButton = false,
    super.buttonText,
    super.onButtonPressed,
    super.onAnimationComplete,
    super.autoDismiss = true,
    super.dismissDelay = const Duration(seconds: 2),
    super.customization = DialogCustomization.success,
  }) : super(animationPath: AppConstants.successAnimation);

  @override
  State<SuccessDialog> createState() => _SuccessDialogState();
}

class _SuccessDialogState extends BaseAnimatedDialogState<SuccessDialog> {
  @override Color get primaryColor => widget.customization.primaryColor ?? AppColors.primary;
  @override Color get backgroundColor => widget.customization.backgroundColor ?? Colors.white;
  @override Color get buttonColor => widget.customization.buttonColor ?? AppColors.primary;
}

class FailureDialog extends BaseAnimatedDialog {
  const FailureDialog({
    super.key,
    required super.title,
    super.message,
    super.showButton = false,
    super.buttonText,
    super.onButtonPressed,
    super.onAnimationComplete,
    super.autoDismiss = true,
    super.dismissDelay = const Duration(seconds: 2),
    super.customization = DialogCustomization.failure,
  }) : super(animationPath: AppConstants.errorAnimation);

  @override
  State<FailureDialog> createState() => _FailureDialogState();
}

class _FailureDialogState extends BaseAnimatedDialogState<FailureDialog> {
  @override Color get primaryColor => widget.customization.primaryColor ?? Colors.red;
  @override Color get backgroundColor => widget.customization.backgroundColor ?? Colors.white;
  @override Color get buttonColor => widget.customization.buttonColor ?? Colors.red;
}

extension DialogExtensions on BuildContext {
  Future<void> showSuccessDialog({
    required String title,
    String? message,
    bool autoDismiss = true,
    AnimationCallback? onAnimationComplete,
  }) {
    return showDialog(
      context: this,
      builder: (context) => SuccessDialog(
        title: title,
        message: message,
        autoDismiss: autoDismiss,
        onAnimationComplete: onAnimationComplete,
      ),
    );
  }

  Future<void> showFailureDialog({
    required String title,
    String? message,
    bool autoDismiss = true,
    AnimationCallback? onAnimationComplete,
  }) {
    return showDialog(
      context: this,
      builder: (context) => FailureDialog(
        title: title,
        message: message,
        autoDismiss: autoDismiss,
        onAnimationComplete: onAnimationComplete,
      ),
    );
  }
}
