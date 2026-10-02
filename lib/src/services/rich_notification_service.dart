import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';

import '../models/rich_notification_model.dart';

class RichNotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
  FlutterLocalNotificationsPlugin();

  static const String _channelId = 'rich_media_notifications';
  static const String _channelName = 'Rich Media Notifications';
  static const String _channelDescription =
      'Notifications with rich images and media';

  static Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const settings = InitializationSettings(
      android: androidSettings,
    );

    await _notifications.initialize(
      settings: settings,
    );

    await _notifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<String> _getNotificationImage() async {
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/notification_img.png');

    if (await file.exists()) {
      return file.path;
    }

    final byteData = await rootBundle.load(
      'assets/images/notificatopn.png',
    );

    await file.writeAsBytes(
      byteData.buffer.asUint8List(),
    );

    return file.path;
  }

  static Future<void> showBigPicture({
    required RichNotificationModel notification,
    int id = 0,
  }) async {
    final imagePath = await _getNotificationImage();

    final bigPicture = BigPictureStyleInformation(
      FilePathAndroidBitmap(imagePath),
      contentTitle: notification.title,
      summaryText: notification.message,
      showBigPictureWhenCollapsed: true,
    );

    final androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      styleInformation: bigPicture,
    );

    final details = NotificationDetails(
      android: androidDetails,
    );

    await _notifications.show(
      id: id,
      title: notification.title,
      body: notification.message,
      notificationDetails: details,
    );
  }

  static Future<void> showMedia({
    required RichNotificationModel notification,
    int id = 0,
  }) async {
    final imagePath = await _getNotificationImage();

    final largeIcon = FilePathAndroidBitmap(imagePath);

    final androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      largeIcon: largeIcon,
      styleInformation: const MediaStyleInformation(),
    );

    final details = NotificationDetails(
      android: androidDetails,
    );

    await _notifications.show(
      id: id,
      title: notification.title,
      body: notification.message,
      notificationDetails: details,
    );
  }

  static Future<void> show({
    required RichNotificationModel notification,
    int id = 0,
  }) async {
    if (notification.style == RichNotificationStyle.bigPicture) {
      await showBigPicture(
        notification: notification,
        id: id,
      );
      return;
    }

    await showMedia(
      notification: notification,
      id: id,
    );
  }

  static Future<void> showBasic({
    required RichNotificationModel notification,
    int id = 0,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const details = NotificationDetails(
      android: androidDetails,
    );

    await _notifications.show(
      id: id,
      title: notification.title,
      body: notification.message,
      notificationDetails: details,
    );
  }

  static Future<void> cancel(int id) async {
    await _notifications.cancel(id: id);
  }

  static Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }
}