import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  static final _firebaseMessaging = FirebaseMessaging.instance;

  static Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final messageToken = await _firebaseMessaging.getToken();
    print('token: $messageToken');
  }
}
