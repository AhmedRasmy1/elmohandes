import '../../../home/presentation/views/home_page_view.dart';
import '../../../../core/di/di.dart';
import '../viewmodel/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  final String fontFamily;

  const LoginPage({
    super.key,
    this.fontFamily = 'Cairo',
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginCubit viewModel;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    viewModel = getIt.get<LoginCubit>();
    super.initState();
  }

  void _showSnackBar(String message, {Color color = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(fontFamily: widget.fontFamily),
        ),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginLoding) {
              setState(() {
                isLoading = true;
              });
            } else {
              setState(() {
                isLoading = false;
              });
            }

            if (state is LoginSuccess) {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) {
                return const ProductsPage();
              }), (route) => false);
            }

            if (state is LoginFailure) {
              _showSnackBar("راجع الايميل والباسورد وحاول تاني");
            }
          },
          builder: (context, state) {
            return Stack(
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
                  color: Colors.black.withAlpha((0.5 * 255).toInt()),
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    bool isMobile = constraints.maxWidth < 600;
                    return Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: isMobile ? constraints.maxWidth * 0.9 : 400,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha((0.9 * 255).toInt()),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: DefaultTextStyle(
                          style: TextStyle(fontFamily: 'Cairo'),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/images/iconapplication.png',
                                  width: isMobile ? 100 : 180,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "المهندس",
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                    fontFamily: 'ArefRuqaa',
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    labelText: "البريد الإلكتروني",
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.email),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "يرجى إدخال البريد الإلكتروني";
                                    }
                                    if (!value.contains("@")) {
                                      return "البريد الإلكتروني غير صحيح";
                                    }
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
                                    onPressed: isLoading
                                        ? null
                                        : () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              viewModel.login(
                                                emailController.text,
                                                passwordController.text,
                                              );
                                            }
                                          },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: isLoading
                                        ? CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : Text(
                                            "تسجيل الدخول",
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
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
