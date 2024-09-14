import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  // إنشاء كائن FlutterLocalNotificationsPlugin
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // تهيئة الإشعارات
  static Future<void> initialize() async {
    // تهيئة إعدادات Android
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('img');

    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {},);

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    _notificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (details) {},
    );

    // تهيئة إعدادات iOS
    final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        // يمكن التعامل مع الإشعارات عند استقبالها في الخلفية هنا
      },
    );


    // تهيئة الإشعارات
    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (
          NotificationResponse notificationResponse) async {},
    );
  }

  // إرسال إشعار
  static Future<void> showNotification(
      {required String title, required String body, required String payload}) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await _notificationsPlugin.show(
        0, title, body, notificationDetails,
        payload: payload);
  }

}
