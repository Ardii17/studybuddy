import 'package:app/services/NotificationService.dart';

class ShowNotification {
  static final NotificationService _notificationService = NotificationService();

  static void showTestNotification(String title, String body) {
    _notificationService.showNotification(
        title: title,
        body: body
    );
  }
}