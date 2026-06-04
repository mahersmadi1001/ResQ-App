import 'package:hive/hive.dart';
import 'package:projct/service/cache_service.dart';

class UserSessionService {
  final String _firstTimeOpenKey = "first_time";

  Future<bool> isFirstTimeOpen() async {
    return await Hive.box(CacheService.boxName).get(_firstTimeOpenKey) ?? true;
  }

  Future<bool> isAuthenticated() async {
    bool hasToken =
        await !(Hive.box(CacheService.boxName).get(CacheService.tokenKey) ==
            null);
    return hasToken;
  }

  Future<void> completeOnboarding() async {
    await Hive.box(CacheService.boxName).put(_firstTimeOpenKey, false);
  }
}
