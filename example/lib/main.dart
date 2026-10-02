import 'package:flutter/material.dart';
import 'package:flutter_rich_media_notifications/flutter_rich_media_notifications.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const RichMediaNotificationExample());
}

class RichMediaNotificationExample extends StatelessWidget {
  const RichMediaNotificationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rich Media Notifications',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F46E5)),
      ),
      home: const NotificationHomeScreen(),
    );
  }
}

class NotificationHomeScreen extends StatelessWidget {
  const NotificationHomeScreen({super.key});

  static const String imageUrl =
      'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rich Media Notifications',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Notification Demo',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Color(0xFF172033),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Test Big Picture and Media Style notifications.',
            style: TextStyle(color: Color(0xFF64748B), fontSize: 15),
          ),
          const SizedBox(height: 24),
          _NotificationCard(
            title: 'Big Picture',
            description: 'Show a large image inside the notification.',
            icon: Icons.image_rounded,
            onPressed: () async {
              await RichNotificationService.initialize();

              const notification = RichNotificationModel(
                title: 'Beautiful Image',
                message: 'This is a Big Picture notification.',
                mediaUrl: imageUrl,
                mediaType: RichNotificationMediaType.image,
                style: RichNotificationStyle.bigPicture,
              );

              await RichNotificationService.show(
                notification: notification,
                id: 1,
              );
            },
          ),
          const SizedBox(height: 16),
          _NotificationCard(
            title: 'Media Style',
            description: 'Show artwork using Android Media Style.',
            icon: Icons.music_note_rounded,
            onPressed: () async {
              await RichNotificationService.initialize();

              const notification = RichNotificationModel(
                title: 'Now Playing',
                message: 'Rich media notification is playing.',
                mediaUrl: imageUrl,
                mediaType: RichNotificationMediaType.image,
                style: RichNotificationStyle.media,
              );

              await RichNotificationService.show(
                notification: notification,
                id: 2,
              );
            },
          ),
          const SizedBox(height: 16),
          _NotificationCard(
            title: 'Basic Notification',
            description: 'Show a notification without media.',
            icon: Icons.notifications_rounded,
            onPressed: () async {
              await RichNotificationService.initialize();

              const notification = RichNotificationModel(
                title: 'Hello!',
                message: 'This is a basic rich notification.',
              );

              await RichNotificationService.showBasic(
                notification: notification,
                id: 3,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onPressed;

  const _NotificationCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: const Color(0xFF4F46E5)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: onPressed,
                  child: const Text('Show Notification'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
