import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_rich_media_notifications/flutter_rich_media_notifications.dart';

void main() {
  testWidgets('RichNotification displays title and message', (tester) async {
    const notification = RichNotificationModel(
      title: 'New Message',
      message: 'You have received a new notification',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RichNotification(
            notification: notification,
          ),
        ),
      ),
    );

    expect(find.text('New Message'), findsOneWidget);
    expect(
      find.text('You have received a new notification'),
      findsOneWidget,
    );
    expect(find.text('Big Picture'), findsOneWidget);
  });

  testWidgets('RichNotification displays Media Style', (tester) async {
    const notification = RichNotificationModel(
      title: 'Now Playing',
      message: 'Playing your favorite song',
      style: RichNotificationStyle.media,
      mediaType: RichNotificationMediaType.image,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RichNotification(
            notification: notification,
          ),
        ),
      ),
    );

    expect(find.text('Now Playing'), findsOneWidget);
    expect(find.text('Playing your favorite song'), findsOneWidget);
    expect(find.text('Media Style'), findsOneWidget);
    expect(find.text('IMAGE'), findsOneWidget);
  });
}