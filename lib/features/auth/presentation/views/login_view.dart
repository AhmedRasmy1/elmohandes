import 'package:elmohandes/core/resources/assets_manager.dart';
import 'package:elmohandes/core/resources/font_manager.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final String fontFamily;

  const LoginPage({super.key, this.fontFamily = FontFamily.cairo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.white, Colors.black],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Semi-transparent overlay
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          // Login form
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo
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
                      TextField(
                        decoration: InputDecoration(
                          labelText: "البريد الإلكتروني",
                          labelStyle: TextStyle(fontFamily: fontFamily),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        style: TextStyle(fontFamily: fontFamily),
                      ),
                      const SizedBox(height: 15),
                      PasswordField(fontFamily: fontFamily),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            "تسجيل الدخول",
                            style: TextStyle(
                                fontSize: 16, fontFamily: FontFamily.cairo),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final String fontFamily;

  const PasswordField({super.key, required this.fontFamily});

  @override
  createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
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
    );
  }
}
