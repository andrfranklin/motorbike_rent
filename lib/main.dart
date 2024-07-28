import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motorbikes_rent/providers/customer.dart';
import 'package:motorbikes_rent/screens/home.dart';
import 'package:motorbikes_rent/screens/rental.dart';
import 'package:motorbikes_rent/screens/sign_up.dart';
import 'package:motorbikes_rent/providers/brand.dart';
import 'package:motorbikes_rent/providers/motorbike.dart';
import 'package:motorbikes_rent/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() async {
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
        },
      ),
    );
  }
}
