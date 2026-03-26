import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mansaa_app/core/helpers/app_states.dart';
import 'package:mansaa_app/core/manager/app_manager.dart';
import 'package:mansaa_app/core/manager/app_manager_state.dart';
import 'package:mansaa_app/core/routing/app_route_names.dart';
import 'package:mansaa_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:mansaa_app/features/auth/presentation/cubit/auth_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Phase 1: Entry
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _haloOpacity;

  // Phase 2: Text Reveal
  late Animation<double> _titleOpacity;
  late Animation<Offset> _titleSlide;
  late Animation<double> _subtitleOpacity;
  late Animation<Offset> _subtitleSlide;

  // Phase 3: Loading Bar
  late Animation<double> _loadingWidth;
  late Animation<double> _loadingOpacity;

  // Phase 4: Exit
  late Animation<double> _exitScale;
  late Animation<double> _exitOpacity;
  late Animation<Color?> _bgFade;

  bool _isAutoLoggingIn = false;
  bool _navigationTriggered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Timing Constants (mapped to 2000ms duration)
    // Phase 1: 0 - 600ms (0.0 to 0.3)
    _logoScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.6,
          end: 1.05,
        ).chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 70,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.05,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 30,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3),
      ),
    );

    _logoOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.2),
    );

    _haloOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.1, 0.3),
    );

    // Phase 2: 500ms - 900ms (0.25 to 0.45)
    _titleOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.25, 0.45),
    );
    _titleSlide = Tween<Offset>(begin: const Offset(0, 20), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.25, 0.45),
          ),
        );

    // Subtitle starts at 650ms (0.325)
    _subtitleOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.325, 0.525),
    );
    _subtitleSlide = Tween<Offset>(begin: const Offset(0, 20), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.325, 0.525),
          ),
        );

    // Phase 3: 800ms - 1600ms (0.4 to 0.8)
    _loadingWidth = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 0.8),
    );
    _loadingOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.75, 0.8),
      ),
    );

    // Phase 4: 1600ms - 2000ms (0.8 to 1.0)
    _exitScale = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.8, 1.0, curve: Curves.easeInCubic),
      ),
    );
    _exitOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.8, 1.0)),
    );
    _bgFade = ColorTween(
      begin: null, // Transparent/Radial background handled in build
      end: Colors.white,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.8, 1.0),
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (!_isAutoLoggingIn && !_navigationTriggered) {
          _navigationTriggered = true;
          context.go(AppRouteNames.login);
        }
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<AppManager, AppManagerState>(
            listener: (context, state) {
              if (!_isAutoLoggingIn &&
                  state.isRememberMe &&
                  state.userCode != null &&
                  state.userPassword != null) {
                setState(() => _isAutoLoggingIn = true);
                context.read<AuthCubit>().loginStudent(
                      studentCode: state.userCode!,
                      studentPassword: state.userPassword!,
                    );
              }
            },
          ),
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state.loginState == AppStates.success) {
                if (!_navigationTriggered) {
                  _navigationTriggered = true;
                  context.goNamed(AppRouteNames.home);
                }
              } else if (state.loginState == AppStates.failure) {
                setState(() => _isAutoLoggingIn = false);
                // If animation is already done, navigate to login
                if (_controller.status == AnimationStatus.completed &&
                    !_navigationTriggered) {
                  _navigationTriggered = true;
                  context.go(AppRouteNames.login);
                }
              }
            },
          ),
        ],
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final Color bgColor = _bgFade.value ?? const Color(0xFFF2D9CE);

            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: bgColor,
                gradient: _bgFade.value != null
                    ? null
                    : const RadialGradient(
                        center: Alignment.center,
                        radius: 1.2,
                        colors: [Color(0xFFF2D9CE), Color(0xFFE8C9B8)],
                      ),
              ),
              child: Opacity(
                opacity: _exitOpacity.value,
                child: Transform.scale(
                  scale: _exitScale.value,
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),

                        // Logo Section
                        Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Halo Dynamic Ring
                              Opacity(
                                opacity: _haloOpacity.value,
                                child: Container(
                                  width: 126,
                                  height: 126,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(
                                        0xFFC8191A,
                                      ).withOpacity(0.4),
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),

                              // White Logo Circle
                              Opacity(
                                opacity: _logoOpacity.value,
                                child: Transform.scale(
                                  scale: _logoScale.value,
                                  child: Container(
                                    width: 110,
                                    height: 110,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(
                                            0xFFC8191A,
                                          ).withOpacity(0.15),
                                          blurRadius: 40,
                                          offset: const Offset(0, 16),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Container(
                                        width: 56,
                                        height: 56,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFC8191A),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: const Icon(
                                          Icons.school_outlined,
                                          color: Colors.white,
                                          size: 32,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Branding Text
                        Opacity(
                          opacity: _titleOpacity.value,
                          child: Transform.translate(
                            offset: _titleSlide.value,
                            child: const Text(
                              "CIS Student Hub",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1A1A1A),
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 4),

                        Opacity(
                          opacity: _subtitleOpacity.value,
                          child: Transform.translate(
                            offset: _subtitleSlide.value,
                            child: const Text(
                              "Your academic life, simplified.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF8C7B72),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),

                        const Spacer(),

                        // Bottom Section
                        Padding(
                          padding: const EdgeInsets.only(bottom: 48),
                          child: Column(
                            children: [
                              // Loading Bar
                              Opacity(
                                opacity: _loadingOpacity.value,
                                child: Container(
                                  width: 140,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE8C9B8),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: FractionallySizedBox(
                                      widthFactor: _loadingWidth.value,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFC8191A),
                                          borderRadius: BorderRadius.circular(2),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(
                                                0xFFC8191A,
                                              ).withOpacity(0.3),
                                              blurRadius: 8,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 16),

                              const Text(
                                "CIS · FACULTY OF COMPUTER & INFORMATION SCIENCES",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF6A5B51),
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
