import 'package:admin/app/data.dart';
import 'package:admin/core/constants/colors.dart';
import 'package:admin/core/constants/constraints.dart';
import 'package:admin/core/constants/text_styles.dart';
import 'package:admin/core/keyboard/dismiss.dart';
import 'package:admin/features/auth/data/auth.dart';
import 'package:admin/features/auth/data/providers/auth_providers.dart';
import 'package:admin/features/auth/presentation/components/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      globalRef!.read(isSignUpLoadingProvider.notifier).state = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          "Create an Account",
          style: headline1.copyWith(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => dismissKeyboard(context),
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 50),
                    SvgPicture.asset(
                      'assets/svg/login.svg',
                      fit: BoxFit.cover,
                      width: 75.w,
                    ),
                    const SizedBox(height: 30),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            label: "Full Name",
                            isPassword: false,
                            inputType: TextInputType.name,
                            controller: _nameController,
                          ),
                          CustomTextField(
                            label: "Email",
                            isPassword: false,
                            inputType: TextInputType.emailAddress,
                            controller: _emailController,
                          ),
                          CustomTextField(
                            label: "Password",
                            isPassword: true,
                            inputType: TextInputType.visiblePassword,
                            controller: _passwordController,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Consumer(
                  builder: (context, ref, child) {
                    bool isLoading = ref.watch(isSignUpLoadingProvider);
                    return Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                ref
                                    .read(isSignUpLoadingProvider.notifier)
                                    .state = true;
                                await AuthService().signUpWithEmail(
                                  _nameController.text,
                                  _emailController.text,
                                  _passwordController.text,
                                );
                              }
                            },
                            child:
                                isLoading
                                    ? const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    )
                                    : const Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        RichText(
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: bodyText1,
                            children: [
                              TextSpan(
                                text: "Log In",
                                style: bodyText1.copyWith(
                                  color: blue,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => const LoginScreen(),
                                          ),
                                        );
                                      },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
