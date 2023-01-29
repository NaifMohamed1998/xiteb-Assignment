import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Initialize the plugin
void initializeNotifications() async {
  var initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

// Schedule the notification
Future<void> scheduleNotification(DateTime dateTime, String title, String body) async {
  var scheduledNotificationDateTime = dateTime;
  // ignore: prefer_const_constructors
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'Event',
    'Alert',
    importance: Importance.max,
    priority: Priority.high,
  );
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics);
  // ignore: deprecated_member_use
  await flutterLocalNotificationsPlugin.schedule(
      0, title, body, scheduledNotificationDateTime, platformChannelSpecifics);
}
