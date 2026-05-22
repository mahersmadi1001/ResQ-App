import 'package:get_it/get_it.dart';
import 'package:projct/service/auth_service.dart';

GetIt di = GetIt.instance;

Future setup() async {
  di.registerSingleton(() => AuthService());
  
}
