import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../locale/locale.dart';
import '../locale/locale_controller.dart';
import '../views/routes.dart';
import 'controllers/change_country.dart';
import 'firebase_options.dart';
import 'views/text_styled.dart';

// used to pass messages from event handler to the UI
final _messageStreamController = BehaviorSubject<RemoteMessage>();

FirebaseMessaging messaging = FirebaseMessaging.instance;

SharedPreferences? appdataprefs;
CountryController countryController = Get.put(CountryController());
String currentVersion = "1.0.4";

// TODO: Define the background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.title}');
    print('Message notification: ${message.notification?.body}');
  }
}

void main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: binding);
  appdataprefs = await SharedPreferences.getInstance();

  // Step 1
  if (appdataprefs?.getString('country') == null) {
    await appdataprefs?.setString('country', 'IRAQ');
    await appdataprefs?.setInt('dropdown', 0);
  }
  // Step 3
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) {
    runApp(const MyApp());
    FlutterNativeSplash.remove();
  });
  //! flutter notification
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final messaging = FirebaseMessaging.instance;

  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (kDebugMode) {
    print('Permission granted: ${settings.authorizationStatus}');
  }
  // It requests a registration token for sending messages to users from your App server or other trusted server environment.
  String? token = await messaging.getToken();

  if (kDebugMode) {
    print('Registration Token=$token');
  }
  // TODO: Set up background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) {
      print('Handling a foreground message: ${message.messageId}');
      print('Message data: ${message.data}');
      print('Message notification: ${message.notification?.title}');
      print('Message notification: ${message.notification?.body}');
    }

    _messageStreamController.sink.add(message);
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    countryController.checkCountries();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(LocaleController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,

      theme: ThemeData(
          primaryColor: const Color(0xff0DB770),
          scaffoldBackgroundColor: const Color(0xFFFFFFFF),
          fontFamily: arabicFont,
          appBarTheme: AppBarTheme(
            backgroundColor: const Color(0xff0DB770).withOpacity(0.8),
            // elevation: 0.7,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          useMaterial3: true,
          scrollbarTheme: ScrollbarThemeData(
              thumbColor:
                  MaterialStateProperty.all(Colors.black.withOpacity(0.5)),
              thumbVisibility: MaterialStateProperty.all(true),
              thickness: MaterialStateProperty.all(3),
              mainAxisMargin: 12,
              crossAxisMargin: 4)),
      title: "view",
      locale: LocaleController().language,
      translations: AppLocale(),
      // make middle ware for login
      initialRoute: '/login',
      getPages: appRoutes,
    );
  }
}
