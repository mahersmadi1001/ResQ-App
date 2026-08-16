import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projct/core/config/di.dart';
import 'package:projct/core/localization/app_localizations.dart';
import 'package:projct/core/localization/localization_bloc/localization_bloc.dart';
import 'package:projct/core/localization/localization_bloc/localization_event.dart';
import 'package:projct/core/localization/localization_bloc/localization_state.dart';
import 'package:projct/core/theme/theme_app.dart';
import 'package:projct/firebase_options.dart';
import 'package:projct/service/cache_service.dart';
import 'package:projct/service/langauge_service.dart';
import 'package:projct/service/map_location_service.dart';
import 'package:projct/service/notfications_service.dart';
import 'package:projct/service/post_service.dart';
import 'package:projct/view_model/map_location_bloc/map_location_bloc.dart';
import 'package:projct/view_model/post_bloc/post_bloc.dart';
import 'package:projct/view_model/report_input_bloc/report_input_bloc.dart';
import 'package:projct/view_model/theme_bloc/theme_bloc.dart';
import 'package:projct/view_model/theme_bloc/theme_state.dart';
import 'package:projct/view_model/user_session_bloc/user_session_bloc.dart';
import 'package:projct/viwe/bottom_nav_bar.dart';
import 'package:projct/viwe/login_screen.dart';
import 'package:projct/viwe/onbording/pagesview.dart';
import 'package:projct/viwe/splash_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projct/core/constens/constens.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setup();
  await NotificationsService(cacheService: di<CacheService>()).getFcm();
  await NotificationsService(cacheService: di<CacheService>()).init();

  try {
    final loader = SvgAssetLoader(ConstensApp.logo);
    svg.cache.putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
    await loader.loadBytes(null);
  } catch (_) {}

  FlutterError.onError = (FlutterErrorDetails details) {
    debugPrint('=== MAP/UI ERROR ===');
    debugPrint(details.exceptionAsString());
    debugPrint(details.stack.toString());
  };
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(436, 732),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LocalizationBloc(
                cacheService: di<CacheService>(),
                langaugeService: LangaugeService(
                  cacheService: di<CacheService>(),
                ),
              )..add(const GetSavedLanguageEvent()),
            ),
            BlocProvider(
              create: (context) => MapLocationBloc(
                service: MapLocationService(cacheService: di<CacheService>()),
              ),
            ),
            BlocProvider(
              create: (context) {
                return ReportInputBloc();
              },
            ),
            BlocProvider(
              create: (context) => PostBloc(postService: di<PostService>()),
            ),
            BlocProvider(
              create: (context) {
                return di<UserSessionBloc>()..add(UserSessionCheckStatus());
              },
            ),
            BlocProvider(create: (context) => ThemeBloc()),
          ],
          child: BlocListener<UserSessionBloc, UserSessionState>(
            listener: (context, state) {
              if (state is UserAuthenticated) {
                navigatorKey.currentState?.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const ButtonNavBar()),
                  (route) => false,
                );
              } else if (state is UserUnAuth) {
                navigatorKey.currentState?.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              } else if (state is UserFirstTimeState) {
                navigatorKey.currentState?.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => OnBordingPageView()),
                  (route) => false,
                );
              }
            },
            child: BlocBuilder<LocalizationBloc, LocalizationState>(
              builder: (context, state) {
                return BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, themestate) {
                    return MaterialApp(
                      themeAnimationDuration: Duration(milliseconds: 500),
                      themeAnimationCurve: Curves.linear,
                      theme: themestate is ThemeLoaded
                          ? (themestate.isDarkMode
                                ? AppTheme.darkTheme
                                : AppTheme.lightTheme)
                          : AppTheme.lightTheme,
                      navigatorKey: navigatorKey,
                      debugShowCheckedModeBanner: false,
                      locale: state is LocalizationSuccessState
                          ? state.langCode
                          : const Locale("en"),
                      supportedLocales: const [Locale('ar'), Locale('en')],
                      localizationsDelegates: const [
                        AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      home: const SplashScreen(),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
