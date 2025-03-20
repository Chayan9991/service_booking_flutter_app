import 'package:flutter/material.dart';
import 'package:service_booking_app/core/dependency_injection/service_locator.dart';
import 'package:service_booking_app/core/routes/app_routes.dart';
import 'package:service_booking_app/data/model/user_model.dart';
import 'package:service_booking_app/presentation/bloc_cubits/auth/cubit/auth_cubit.dart';
import 'package:service_booking_app/presentation/screens/auth/login_screen.dart';

class HomeScreen extends StatelessWidget {
  final UserModel user;
  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [InkWell(
            onTap: () async {
              await getIt<AuthCubit>().signOut();

              getIt<AppRoutes>().pushAndRemoveUntil(const LoginScreen());
            },
            child: Icon(Icons.logout),
          ),]),
      body: Column(
        children: [Center(child: Text("Welcome Home ${user.fullName}"))],
      ),
    );
  }
}
