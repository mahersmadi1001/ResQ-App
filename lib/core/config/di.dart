import 'package:get_it/get_it.dart';
import 'package:projct/service/auth_service.dart';
import 'package:projct/service/cache_service.dart';

GetIt di = GetIt.instance;

Future setup() async {
  final cacheService = CacheService();
  await cacheService.init();
  di.registerLazySingleton<CacheService>(() => cacheService);
  di.registerLazySingleton<AuthService>(() => AuthService());
}
