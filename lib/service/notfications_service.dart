import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:projct/core/network/api_constants.dart';
import 'package:projct/service/cache_service.dart';

class NotificationsService {
  CacheService cacheService;
  NotificationsService({required this.cacheService});
  Future getFcm() async {
    try {
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      print("fcm++++++++++++++++++++++++++++++++++++");
      print(fcmToken);
      return fcmToken;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> sendFcm({required String fcmToken}) async {
    try {
      Response response = await Dio().post(
        "${ApiConstants.baseurl}user/fcm",
        data: {"token": fcmToken},
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${cacheService.getToken()}',
          },
        ),
      );
      if (response.statusCode == 200) {
        print("200 send fcm token ");
      } else {
        print("falure send fcm token ");
      }
    } catch (e) {
      print("error fcm token");
      print(e.toString());
    }
  }

  Future<void> apprequestPermissions() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }
}
