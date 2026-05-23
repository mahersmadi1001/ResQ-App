import 'package:hive_flutter/hive_flutter.dart';
import 'package:projct/model/user_model.dart';

class CacheService {
  static const String _boxName = 'auth_box';
  static const String _tokenKey = 'token';
  static const String _userKey = 'user';

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    await Hive.openBox(_boxName);
  }

  Future<void> saveToken(String token) async {
    final box = Hive.box(_boxName);
    await box.put(_tokenKey, token);
  }

  String? getToken() {
    final box = Hive.box(_boxName);
    return box.get(_tokenKey);
  }

  Future<void> deleteToken() async {
    final box = Hive.box(_boxName);
    await box.delete(_tokenKey);
  }

  Future<void> saveUser(UserModel user) async {
    final box = Hive.box(_boxName);
    await box.put(_userKey, user);
  }

  UserModel? getUser() {
    final box = Hive.box(_boxName);
    return box.get(_userKey);
  }

  Future<void> deleteUser() async {
    final box = Hive.box(_boxName);
    await box.delete(_userKey);
  }
}
