import 'package:flutter/material.dart';
import 'package:service_booking_app/config/themes/app_theme.dart';
import 'package:service_booking_app/core/dependency_injection/service_locator.dart';
import 'package:service_booking_app/core/routes/app_routes.dart';
import 'package:service_booking_app/presentation/screens/auth/login_screen.dart';

void main() async {
  await setupServiceLocator(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      navigatorKey: getIt<AppRoutes>().navigationKey,
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
