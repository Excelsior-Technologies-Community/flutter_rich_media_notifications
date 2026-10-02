import '../models/rich_notification_model.dart';

class ThumbnailLoader {
  static RichNotificationMediaType detectMediaType(String url) {
    final value = url.toLowerCase().split('?').first;

    if (value.endsWith('.gif')) {
      return RichNotificationMediaType.gif;
    }

    if (value.endsWith('.mp4') ||
        value.endsWith('.mov') ||
        value.endsWith('.webm') ||
        value.endsWith('.mkv')) {
      return RichNotificationMediaType.video;
    }

    return RichNotificationMediaType.image;
  }

  static String? getThumbnailUrl(
      String? mediaUrl, {
        RichNotificationMediaType? mediaType,
      }) {
    if (mediaUrl == null || mediaUrl.isEmpty) {
      return null;
    }

    final type = mediaType ?? detectMediaType(mediaUrl);

    if (type == RichNotificationMediaType.image) {
      return mediaUrl;
    }

    if (type == RichNotificationMediaType.gif) {
      return mediaUrl;
    }

    if (type == RichNotificationMediaType.video) {
      return mediaUrl;
    }

    return null;
  }

  static bool isImage(String url) {
    return detectMediaType(url) == RichNotificationMediaType.image;
  }

  static bool isGif(String url) {
    return detectMediaType(url) == RichNotificationMediaType.gif;
  }

  static bool isVideo(String url) {
    return detectMediaType(url) == RichNotificationMediaType.video;
  }
}