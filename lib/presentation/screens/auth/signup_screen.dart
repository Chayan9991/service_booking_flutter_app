import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_booking_app/core/common/custom_button.dart';
import 'package:service_booking_app/core/common/custom_textfield.dart';
import 'package:service_booking_app/core/dependency_injection/service_locator.dart';
import 'package:service_booking_app/core/routes/app_routes.dart';
import 'package:service_booking_app/core/utils/ui_utils.dart';
import 'package:service_booking_app/presentation/bloc_cubits/auth/cubit/auth_cubit.dart';
import 'package:service_booking_app/presentation/screens/main/home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  bool _isPasswordVisible = false;
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _phoneFocus = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _phoneFocus.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your full name";
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your email address";
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return "Please enter a valid email (e.g., example@gmail.com)";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a password";
    }
    if (value.length < 6) {
      return "Password must be at least 6 character long";
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your phone number";
    }
    final phoneRegex = RegExp(r'^\+?[\d\s-]{10,}$');
    if (!phoneRegex.hasMatch(value)) {
      return "Please enter a valid phone (e.g., +1234567890)";
    }
    return null;
  }

  Future<void> _handleSignUp() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final user = await getIt<AuthCubit>().signUp(
          fullName: nameController.text,
          email: emailController.text,
          phoneNumber: phoneController.text,
          password: passwordController.text,
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } else {
      print("Form validation failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      bloc: getIt<AuthCubit>(),
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          final user = state.user;
          getIt<AppRoutes>().pushAndRemoveUntil(HomeScreen(user: user!));
        } else if (state.status == AuthStatus.error && state.error != null) {
          UiUtils.showSnackBar(context, message: state.error!, isError: true);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double maxWidth =
                      constraints.maxWidth > 600 ? 400 : double.infinity;

                  return Container(
                    width: maxWidth,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Create Account",
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Please fill in the details to continue",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey),
                          ),
                          const SizedBox(height: 30),
                          CustomTextField(
                            controller: nameController,
                            validator: _validateName,
                            focusNode: _nameFocus,
                            hintText: "Full Name",
                            prefixIcon: const Icon(Icons.person_outlined),
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: _validateEmail,
                            focusNode: _emailFocus,
                            hintText: "Email",
                            prefixIcon: const Icon(Icons.mail_outlined),
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: phoneController,
                            validator: _validatePhone,
                            focusNode: _phoneFocus,
                            hintText: "Phone Number",
                            prefixIcon: const Icon(Icons.phone_outlined),
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: passwordController,
                            validator: _validatePassword,
                            focusNode: _passwordFocus,
                            hintText: "Password",
                            obscureText: !_isPasswordVisible,
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              child:
                                  _isPasswordVisible
                                      ? const Icon(
                                        Icons.visibility_off_outlined,
                                      )
                                      : const Icon(Icons.visibility_outlined),
                            ),
                          ),
                          const SizedBox(height: 30),
                          CustomButton(
                            onPressed: _handleSignUp,
                            child:
                                state.status == AuthStatus.loading
                                    ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                    : const Text(
                                      "Create Account",
                                      style: TextStyle(color: Colors.white),
                                    ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: "Already have an account?",
                                style: TextStyle(color: Colors.grey.shade600),
                                children: [
                                  TextSpan(
                                    text: " Login",
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer:
                                        TapGestureRecognizer()
                                          ..onTap = () {
                                            getIt<AppRoutes>().pop(context);
                                          },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
