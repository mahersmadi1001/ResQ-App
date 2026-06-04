import 'package:hive_flutter/hive_flutter.dart';
import 'package:projct/model/user_model.dart';

class CacheService {
  static const String boxName = 'auth_box';
  static const String tokenKey = 'token';
  static const String _userKey = 'user';

  Box get _box => Hive.box(boxName);

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    await Hive.openBox(boxName);
  }

  Future<void> saveToken(String token) async {
    await _box.put(tokenKey, token);
  }

  String? getToken() {
    return _box.get(tokenKey);
  }

  Future<void> deleteToken() async {
    await _box.delete(tokenKey);
  }

  Future<void> saveUser(UserModel user) async {
    await _box.put(_userKey, user);
  }

  UserModel? getUser() {
    return _box.get(_userKey);
  }

  Future<void> deleteUser() async {
    await _box.delete(_userKey);
  }
}
