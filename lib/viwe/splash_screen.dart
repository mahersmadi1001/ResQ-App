import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projct/core/constens/constens.dart';
import 'package:projct/core/theme/colors_app.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final loader = SvgAssetLoader(ConstensApp.logo);
    svg.cache.putIfAbsent(
      loader.cacheKey(null),
      () => loader.loadBytes(null),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, -0.1),
            radius: 1.1,
            colors: [
              AppColors.greenPro.withOpacity(0.9),
              AppColors.greenPro,
              const Color(0xFF0B2121),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 3),

            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 170.w,
                  height: 170.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.yellowPro.withOpacity(0.2),
                        blurRadius: 60,
                        spreadRadius: 15,
                      ),
                    ],
                  ),
                ),

                SvgPicture.asset(
                      ConstensApp.logo,
                      fit: BoxFit.contain,
                      width: 190.w,
                      height: 190.h,
                    )
                    .animate()
                    .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                    .scale(
                      begin: const Offset(0.6, 0.6),
                      end: const Offset(1.0, 1.0),
                      duration: 700.ms,
                      curve: Curves.easeOutBack,
                    )
                    .then(delay: 50.ms)
                    .shimmer(
                      duration: 1000.ms,
                      color: AppColors.yellowPro.withOpacity(0.4),
                    ),
              ],
            ),

            SizedBox(height: 35.h),

            Text(
                  "ResQ",
                  style: TextStyle(
                    color: AppColors.yellowPro,
                    fontSize: 38.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 3.w,
                    shadows: [
                      Shadow(
                        color: AppColors.yellowPro.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                )
                .animate(delay: 200.ms)
                .fadeIn(duration: 500.ms)
                .slideY(
                  begin: 0.3,
                  end: 0,
                  duration: 500.ms,
                  curve: Curves.easeOutCubic,
                ),

            SizedBox(height: 6.h),
            Text(
              "EMERGENCY SYSTEM",
              style: TextStyle(
                color: AppColors.whitePro.withOpacity(0.6),
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: 4.w,
              ),
            ).animate(delay: 350.ms).fadeIn(duration: 500.ms),

            const Spacer(flex: 2),

            SizedBox(
                  width: 200.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: LinearProgressIndicator(
                      minHeight: 4.h,
                      backgroundColor: AppColors.yellowPro.withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.yellowPro,
                      ),
                    ),
                  ),
                )
                .animate(delay: 450.ms)
                .fadeIn(duration: 400.ms)
                .scaleX(
                  begin: 0.5,
                  end: 1.0,
                  duration: 500.ms,
                  curve: Curves.easeOut,
                ),

            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}
