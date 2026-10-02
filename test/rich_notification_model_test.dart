import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_rich_media_notifications/flutter_rich_media_notifications.dart';

void main() {
  test('RichNotificationModel stores notification data correctly', () {
    const notification = RichNotificationModel(
      title: 'New Offer',
      message: 'Get 30% off today',
      mediaUrl: 'https://example.com/image.jpg',
      mediaType: RichNotificationMediaType.image,
      style: RichNotificationStyle.bigPicture,
    );

    expect(notification.title, 'New Offer');
    expect(notification.message, 'Get 30% off today');
    expect(notification.mediaUrl, 'https://example.com/image.jpg');
    expect(
      notification.mediaType,
      RichNotificationMediaType.image,
    );
    expect(
      notification.style,
      RichNotificationStyle.bigPicture,
    );
    expect(notification.autoThumbnail, true);
  });

  test('copyWith updates notification data', () {
    const notification = RichNotificationModel(
      title: 'Old Title',
      message: 'Old Message',
    );

    final updated = notification.copyWith(
      title: 'New Title',
      message: 'New Message',
      style: RichNotificationStyle.media,
    );

    expect(updated.title, 'New Title');
    expect(updated.message, 'New Message');
    expect(updated.style, RichNotificationStyle.media);
  });
}