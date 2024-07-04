import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/firebase_options.dart';
import 'package:nishauri/src/app/app.dart';
import 'package:nishauri/src/shared/interfaces/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize firebase messaging
  await NotificationService.initializeFirebaseMessaging();

  // Initialize local notifications
  await NotificationService.initializeLocalNotifications();

  runApp(
    const ProviderScope(child: NishauriApp()),
  );
}
