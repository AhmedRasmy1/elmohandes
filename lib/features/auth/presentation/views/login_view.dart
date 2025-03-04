import 'package:awesome_dialog/awesome_dialog.dart';

import '../../../../core/di/di.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/routes_manager.dart';
import '../viewmodel/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  final String fontFamily;

  const LoginPage({
    super.key,
    this.fontFamily = FontFamily.cairo,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginCubit viewModel;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    viewModel = getIt.get<LoginCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginLoding) {
              Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is LoginSuccess) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.bottomSlide,
                title: 'نجاح',
                desc: 'تم تسجيل الدخول بنجاح',
                btnOkOnPress: () {
                  Navigator.pushNamed(context, RoutesManager.productsPage);
                },
              ).show();
            }
            if (state is LoginFailure) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.bottomSlide,
                title: 'راجع الايميل والباسور وحاول تاني',
                btnOkOnPress: () {},
              ).show();
            }
          },
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.white, Colors.black],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.5),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  bool isMobile = constraints.maxWidth < 600;
                  return Center(
                    child: Container(
                      width: isMobile ? constraints.maxWidth * 0.9 : 400,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              AssetsManager.logoImage,
                              width: isMobile ? 70 : 150,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "تسجيل الدخول",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                fontFamily: FontFamily.cairoSemiBold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: "البريد الإلكتروني",
                                labelStyle:
                                    TextStyle(fontFamily: widget.fontFamily),
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.email),
                              ),
                              style: TextStyle(fontFamily: widget.fontFamily),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "يرجى إدخال البريد الإلكتروني";
                                }
                                // if (!value.contains("@")) {
                                //   return "البريد الإلكتروني غير صحيح";
                                // }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            PasswordField(
                              fontFamily: widget.fontFamily,
                              controller: passwordController,
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    viewModel.login(
                                      emailController.text,
                                      passwordController.text,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  "تسجيل الدخول",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: FontFamily.cairo,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final String fontFamily;
  final TextEditingController controller;

  const PasswordField({
    super.key,
    required this.fontFamily,
    required this.controller,
  });

  @override
  createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: "كلمة المرور",
        labelStyle: TextStyle(fontFamily: widget.fontFamily),
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
      style: TextStyle(fontFamily: widget.fontFamily),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "يرجى إدخال كلمة المرور";
        }
        if (value.length < 6) {
          return "يجب أن تحتوي كلمة المرور على 6 أحرف على الأقل";
        }
        return null;
      },
    );
  }
}
