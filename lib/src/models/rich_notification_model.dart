enum RichNotificationStyle {
  bigPicture,
  media,
}

enum RichNotificationMediaType {
  image,
  gif,
  video,
}

class RichNotificationModel {
  final String title;
  final String message;
  final String? mediaUrl;
  final RichNotificationMediaType? mediaType;
  final RichNotificationStyle style;
  final bool autoThumbnail;

  const RichNotificationModel({
    required this.title,
    required this.message,
    this.mediaUrl,
    this.mediaType,
    this.style = RichNotificationStyle.bigPicture,
    this.autoThumbnail = true,
  });

  RichNotificationModel copyWith({
    String? title,
    String? message,
    String? mediaUrl,
    RichNotificationMediaType? mediaType,
    RichNotificationStyle? style,
    bool? autoThumbnail,
  }) {
    return RichNotificationModel(
      title: title ?? this.title,
      message: message ?? this.message,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      mediaType: mediaType ?? this.mediaType,
      style: style ?? this.style,
      autoThumbnail: autoThumbnail ?? this.autoThumbnail,
    );
  }
}