import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_booking_app/config/themes/app_theme.dart';
import 'package:service_booking_app/core/dependency_injection/service_locator.dart';
import 'package:service_booking_app/core/routes/app_routes.dart';
import 'package:service_booking_app/presentation/bloc_cubits/auth/cubit/auth_cubit.dart';
import 'package:service_booking_app/presentation/bloc_cubits/main/cubit/main_cubit.dart';
import 'package:service_booking_app/presentation/bloc_cubits/payment/cubit/payment_cubit.dart';
import 'package:service_booking_app/presentation/screens/main/main_layout.dart';

void main() async {
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<MainCubit>()),
        BlocProvider(create: (context) => getIt<PaymentCubit>()),
      ],
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        navigatorKey: getIt<AppRoutes>().navigationKey,
        debugShowCheckedModeBanner: false,
        home: MainScreen(),
      ),
    );
  }
}
