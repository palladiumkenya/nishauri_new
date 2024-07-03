import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nishauri/src/features/appointments/data/models/appointment.dart';
import 'package:nishauri/src/features/dawa_drop/data/models/order_request/drug_order.dart';

enum SubscriptionType {
  appointments,
  drugDeliveryDispatched,
}

abstract class NotificationService {
  static final firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsplugin =
      FlutterLocalNotificationsPlugin();
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
    playSound: true,
  );

  // Request for permissions
  static Future<void> initializeFirebaseMessaging() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    debugPrint('User granted permission: ${settings.authorizationStatus}');

    // Get device FCM token
    final token = await firebaseMessaging.getToken();
    debugPrint('FCM Token: $token');

    // Set foreground notification presentation options
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        NotificationService.flutterLocalNotificationsplugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              NotificationService.channel.id,
              NotificationService.channel.name,
              channelDescription: NotificationService.channel.description,
              importance: Importance.max,
              priority: Priority.high,
              showWhen: false,
              playSound: true,
              icon: '@mipmap/launcher_icon',
            ),
          ),
        );
      }
    });
  }

  static void handleOpenNotification(context) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(notification.title!),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(notification.body!)],
              ),
            ),
          ),
        );
      }
    });
  }

  // Initialize local notifications
  static Future<void> initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsplugin.initialize(initializationSettings);
    await flutterLocalNotificationsplugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    debugPrint('Handling a background message: ${message.messageId}');
  }

  // Method to subscribe to topics based on appointment date
  static Future<void> subscribeToTopic<T>(
      List<T> dataList, SubscriptionType type) async {
    await Firebase.initializeApp();
    for (var data in dataList) {
      switch (type) {
        case SubscriptionType.appointments:
          final appointment = data as Appointment;
          final appointmentDate = DateTime.parse(appointment.appointment_date);
          final now = DateTime.now();
          final difference = appointmentDate.difference(now).inDays;

          if (difference == 7 || difference == 1) {
            const topic = "AppointmentReminder";
            await firebaseMessaging.subscribeToTopic(topic);
            debugPrint(
                "Subscribed to topic: $topic for appointment on $appointmentDate");
          }
          break;
        case SubscriptionType.drugDeliveryDispatched:
          final order = data as DrugOrder;
          if (order.status == 'Dispatched') {
            const topic = "DrugDeliveryDispatched";
            await firebaseMessaging.subscribeToTopic(topic);
            debugPrint("Subscribed to topic: $topic for dispatched order");
          }
          break;
      }
      break;
    }
  }
}
