import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/services/local_notification_service.dart';
import 'package:weather_app/utils/app_theme.dart';
import 'package:weather_app/utils/home_page_ui.dart';

//This for handling messages when app is terminated
Future<void> _backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LocalNotificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDay = true;

  @override
  void initState() {
    super.initState();
    if (DateTime.now().hour >= 18 || DateTime.now().hour >= 18) {
      isDay = false;
    }
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print(
            "I am listening to any messages coming while app is in terminated state");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );
    //Foreground
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging foregoround listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
        }
        LocalNotificationService.display(message);
      },
    );
    //BackGround
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging background listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        themeMode: isDay == true ? ThemeMode.light : ThemeMode.dark,
        theme: MyTheme.lightThemeData,
        darkTheme: MyTheme.darkThemeData,
        debugShowCheckedModeBanner: false,
        home: HomePageUi(
          isDay: isDay,
        ));
  }
}
