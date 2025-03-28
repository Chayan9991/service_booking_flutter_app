import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:service_booking_app/core/routes/app_routes.dart';
import 'package:service_booking_app/data/repositories/auth/auth_repo_impl.dart';
import 'package:service_booking_app/firebase_options.dart';
import 'package:service_booking_app/logic/services/razorpay_service.dart';
import 'package:service_booking_app/presentation/bloc_cubits/auth/cubit/auth_cubit.dart';
import 'package:service_booking_app/presentation/bloc_cubits/main/cubit/main_cubit.dart';
import 'package:service_booking_app/presentation/bloc_cubits/payment/cubit/payment_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  WidgetsFlutterBinding.ensureInitialized(); 

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  getIt.registerLazySingleton(() => AppRoutes());
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => AuthRepoImpl());
  getIt.registerLazySingleton(() => AuthCubit(authRepository: getIt()));
  getIt.registerLazySingleton(() => MainCubit());
  getIt.registerLazySingleton<PaymentCubit>(() => PaymentCubit());
  getIt.registerLazySingleton<RazorpayService>(
    () => RazorpayService(),
  );
}
