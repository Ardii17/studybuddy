import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/studybuddy'); // Gunakan ikon default

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        // Handler jika notifikasi diterima
        print('Notifikasi diterima: ${details.payload}');
      },
      onDidReceiveBackgroundNotificationResponse: _backgroundNotificationHandler,
    );
  }

  @pragma('vm:entry-point')
  static void _backgroundNotificationHandler(NotificationResponse details) {
    // Handler untuk notifikasi di background
    print('Background Notification: ${details.payload}');
  }

  Future<void> showNotification({
    required String title,
    required String body
  }) async {
    try {
      // Buat channel notifikasi
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description: 'This channel is used for important notifications.',
        importance: Importance.high,
      );

      // Dapatkan instance channel
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      // Konfigurasi detail notifikasi
      final AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
        'high_importance_channel', // channel id
        'High Importance Notifications', // channel name
        channelDescription: 'Channel untuk notifikasi penting',
        importance: Importance.high,
        priority: Priority.high,
        showWhen: true,
        icon: '@mipmap/studybuddy', // Pastikan ikon tersedia
      );

      // Detail platform
      final NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
      );

      // Tampilkan notifikasi
      await flutterLocalNotificationsPlugin.show(
        DateTime.now().millisecondsSinceEpoch.remainder(100000), // ID unik
        title,
        body,
        platformChannelSpecifics,
        payload: 'custom_payload', // Opsional
      );

      print('Notifikasi berhasil dibuat'); // Debug print
    } catch (e) {
      print('Error menampilkan notifikasi: $e');
    }
  }
}