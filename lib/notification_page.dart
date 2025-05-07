import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String? _fcmToken;

  @override
  void initState() {
    super.initState();
    _setupFCM();
  }

  void _setupFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission();
    String? token = await messaging.getToken();
    print('🔑 FCM Token: $token');
    setState(() => _fcmToken = token);

    FirebaseMessaging.onMessage.listen((message) {
      print('📬 Foreground message: ${message.notification?.title}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Push Notifications')),
      body: Center(
        child: SelectableText(
          _fcmToken ?? 'Fetching FCM token...',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
