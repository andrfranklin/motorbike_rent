import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motorbikes_rent/providers/customer.dart';
import 'package:motorbikes_rent/screens/home.dart';
import 'package:motorbikes_rent/screens/profile.dart';
import 'package:motorbikes_rent/screens/rental.dart';
import 'package:motorbikes_rent/screens/sign_up.dart';
import 'package:motorbikes_rent/providers/brand.dart';
import 'package:motorbikes_rent/providers/motorbike.dart';
import 'package:motorbikes_rent/utils/app_routes.dart';
import 'package:motorbikes_rent/utils/firebase_config.dart';
import 'package:provider/provider.dart';

Future<void> handleNotifications(RemoteMessage? message) async {
  if (message == null) return;
  print('Title: ${message.notification?.title}');
  print('body: ${message.notification?.body}');
  print('payload: ${message.data}');
}

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Garante que o binding do Flutter esteja inicializado
  await Firebase.initializeApp(options: FirebaseConfig.androidConfig);
  FirebaseMessaging.onBackgroundMessage(handleNotifications);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MotorbikeProvider()),
        ChangeNotifierProvider(create: (context) => BrandProvider()),
        ChangeNotifierProvider(create: (context) => CustomerProvider()),
      ],
      child: MaterialApp(
        title: 'mbr',
        theme: ThemeData(
            colorScheme: const ColorScheme.light(primary: Colors.black),
            useMaterial3: true,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: GoogleFonts.mulishTextTheme()),
        home: Home(),
        routes: {
          AppRoutes.SIGN_UP: (ctx) => const SignUpPage(),
          AppRoutes.RENTAL_LIST: (ctx) => RentalScreen(),
          AppRoutes.PROFILE: (context) => ProfileScreen()
        },
      ),
    );
  }
}
