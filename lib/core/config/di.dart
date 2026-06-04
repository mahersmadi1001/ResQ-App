import 'package:get_it/get_it.dart';
import 'package:projct/service/auth_service.dart';
import 'package:projct/service/cache_service.dart';
import 'package:projct/service/user_session_service.dart';
import 'package:projct/view_model/user_session_bloc/user_session_bloc.dart';

GetIt di = GetIt.instance;

Future setup() async {
  final cacheService = CacheService();
  await cacheService.init();
  di.registerLazySingleton<UserSessionService>(() => UserSessionService());
  di.registerLazySingleton<CacheService>(() => cacheService);
  di.registerFactory<UserSessionBloc>(
    () => UserSessionBloc(
      userSessionService: di<UserSessionService>(),
      cacheService: cacheService,
    ),
  );
  di.registerLazySingleton<AuthService>(() => AuthService());
}
