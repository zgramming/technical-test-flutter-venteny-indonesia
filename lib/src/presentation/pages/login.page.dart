import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../config/color.dart';
import '../../config/font.dart';
import '../../config/routes.dart';
import '../../core/helper/function.helper.dart';
import '../../core/helper/share_preferences.helper.dart';
import '../cubit/auth.cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isObscure = true;
  bool isLoading = false;

  void toggleObscure() {
    setState(() => isObscure = !isObscure);
  }

  Future<void> onSubmit() async {
    final validate = _formKey.currentState?.validate() ?? false;
    log("Validate: $validate");
    if (!validate) return;

    final email = emailController.text;
    final password = passwordController.text;
    context.read<AuthCubit>().login(email, password);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (ctx, state) async {
          if (state is AuthStateLoading) {
            setState(() => isLoading = true);
            return;
          }

          if (state is AuthStateError) {
            setState(() => isLoading = false);

            // Show snackbar
            ScaffoldMessenger.of(ctx).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }

          if (state is AuthStateSuccess) {
            setState(() => isLoading = false);

            // Save login credential to local storage
            await SharedPreferencesHelper.setLoginCredential(state.auth.token);

            if (ctx.mounted) {
              GoRouter.of(ctx).goNamed(RoutersName.welcome);
            }
          }
        },
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  decoration: const BoxDecoration(
                    color: primaryColor,
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sign in with your account",
                        style: headerFont.copyWith(
                          color: Colors.white,
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Please enter your email and password to continue using our app",
                        style: bodyFont.copyWith(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 9,
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 32.0),
                        ...[
                          Text(
                            "Email",
                            style: bodyFont.copyWith(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: emailController,
                            decoration: FunctionHelper.inputFilledDecoration(
                              hintText: "Enter your email",
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            style: bodyFont.copyWith(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return "Email is required";
                              }

                              final isValidEmail = RegExp(
                                      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+')
                                  .hasMatch(value ?? "");
                              if (!isValidEmail) {
                                return "Invalid email format";
                              }

                              return null;
                            },
                            onTapOutside: (event) =>
                                FocusScope.of(context).unfocus(),
                          ),
                        ],
                        const SizedBox(height: 16.0),
                        ...[
                          Text(
                            "Password",
                            style: bodyFont.copyWith(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: passwordController,
                            decoration: FunctionHelper.inputFilledDecoration(
                              hintText: "Enter your password",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: toggleObscure,
                              ),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            obscureText: isObscure,
                            style: bodyFont.copyWith(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return "Password is required";
                              }

                              final isValidLength = (value?.length ?? 0) >= 8;

                              if (!isValidLength) {
                                return "Password must be at least 8 characters";
                              }

                              return null;
                            },
                            onTapOutside: (event) =>
                                FocusScope.of(context).unfocus(),
                          ),
                        ],
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: onSubmit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            padding: const EdgeInsets.all(16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          // child: Text(
                          //   "Sign in",
                          //   style: bodyFont.copyWith(
                          //     color: Colors.white,
                          //     fontSize: 16.0,
                          //   ),
                          // ),
                          child: isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : Text(
                                  "Sign in",
                                  style: bodyFont.copyWith(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
