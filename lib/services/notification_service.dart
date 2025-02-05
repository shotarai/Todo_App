import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initSettings = InitializationSettings(android: androidInit);
    await _notificationsPlugin.initialize(initSettings);
  }

  Future<void> scheduleNotification(int taskId, String title, DateTime dueDate) async {
    // DateTime を TZDateTime に変換
    final tz.TZDateTime notificationTime = tz.TZDateTime.from(
      dueDate.subtract(Duration(minutes: 10)), // 10分前に通知
      tz.local,
    );

    await _notificationsPlugin.zonedSchedule(
      taskId,
      title,
      'タスクの時間が近づいています！',
      notificationTime,
      const NotificationDetails(
        android: AndroidNotificationDetails('task_channel', 'Task Notifications', importance: Importance.high),
      ),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime, // 追加
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
