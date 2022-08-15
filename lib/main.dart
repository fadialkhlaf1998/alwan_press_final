import 'package:alwan_press/app_localization.dart';
import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/helper/myTheme.dart';
import 'package:alwan_press/helper/store.dart';
import 'package:alwan_press/view/intro.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:  'This channel is used for important notifications.', // description
  importance: Importance.max,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackhroundHadler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('backgrounf message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackhroundHadler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    sound: true,
    alert: true,
    badge: true,
  );

  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: MyTheme.isDarkTheme.value ? Colors.black : Colors.white,
  ));
}


class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);


  static void set_local(BuildContext context , Locale locale){
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.set_locale(locale);
  }

  static void setTheme(BuildContext context){
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setDark();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Locale? _locale;
  Rx<MyTheme> myTheme = MyTheme().obs;

  void set_locale(Locale locale){
    setState(() {
      _locale=locale;
    });
  }

  @override
  void initState() {
    Store.loadTheme().then((value) {
      MyTheme.isDarkTheme.value = !value;
    });
    Global.loadLanguage().then((language) {
      setState(() {
        _locale= Locale(language);
      });
    });
    super.initState();
    FirebaseMessaging.instance.getToken().then((value) {
      print(value);
      setState(() {
        if(value!=null){
          Global.token = value;
        }

      });
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      RemoteNotification notification = message.notification!;
      AndroidNotification androd = message.notification!.android!;
      if(notification != null && androd !=null){
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                    channel.id,
                    channel.name,
                    channelDescription: channel.description,
                    playSound: true,
                    icon: "@mipmap/ic_launcher"
                )
            )
        );
      }
    });
  }

  void setDark(){
    setState(() {
      myTheme.value.myTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: myTheme.value.myTheme,
        theme: MyTheme.lightTheme,
        darkTheme: MyTheme.darkTheme,
        locale: _locale,
        supportedLocales: [Locale('en', ''), Locale('ar', '')],
        localizationsDelegates: const [
          App_Localization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (local, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == local!.languageCode) {
              Global.langCode = supportedLocale.languageCode;
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        home: Intro()
      // home: Addresses_2()
    );
  }
}
