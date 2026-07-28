import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projct/core/constens/constens.dart';
import 'package:projct/core/theme/colors_app.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.1),
            radius: 1.1,
            colors: [
              ColorsApp.greenPro.withOpacity(0.9),
              ColorsApp.greenPro,
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
                        color: ColorsApp.yalwoPro.withOpacity(0.2),
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
                    .fadeIn(duration: 800.ms, curve: Curves.easeOut)
                    .scale(
                      begin: const Offset(0.5, 0.5),
                      end: const Offset(1.0, 1.0),
                      duration: 900.ms,
                      curve: Curves.easeOutBack,
                    )
                    .then(delay: 100.ms)
                    .shimmer(
                      duration: 1200.ms,
                      color: ColorsApp.yalwoPro.withOpacity(0.4),
                    ),
              ],
            ),

            SizedBox(height: 35.h),

            Text(
                  "ResQ",
                  style: TextStyle(
                    color: ColorsApp.yalwoPro,
                    fontSize: 38.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 3.w,
                    shadows: [
                      Shadow(
                        color: ColorsApp.yalwoPro.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                )
                .animate(delay: 350.ms)
                .fadeIn(duration: 600.ms)
                .slideY(
                  begin: 0.3,
                  end: 0,
                  duration: 600.ms,
                  curve: Curves.easeOutCubic,
                ),

            SizedBox(height: 6.h),
            Text(
              "EMERGENCY SYSTEM",
              style: TextStyle(
                color: ColorsApp.withePro.withOpacity(0.6),
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: 4.w,
              ),
            ).animate(delay: 500.ms).fadeIn(duration: 600.ms),

            const Spacer(flex: 2),

            SizedBox(
                  width: 200.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: LinearProgressIndicator(
                      minHeight: 4.h,
                      backgroundColor: ColorsApp.yalwoPro.withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        ColorsApp.yalwoPro,
                      ),
                    ),
                  ),
                )
                .animate(delay: 700.ms)
                .fadeIn(duration: 500.ms)
                .scaleX(
                  begin: 0.5,
                  end: 1.0,
                  duration: 600.ms,
                  curve: Curves.easeOut,
                ),

            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}
