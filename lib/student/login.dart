import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:labtrack/student/homepage.dart';
import 'package:labtrack/student/studentreg.dart';

Dio dio = Dio();
String baseurl = 'http://192.168.1.150:8000';
int? loginid;

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  // 🎓 College Theme Colors
  static const Color primaryColor = Color(0xFF1E3A8A);
  static const Color backgroundColor = Color(0xFFF8FAFC);
  static const Color textColor = Color(0xFF111827);
  static const Color subTextColor = Color(0xFF6B7280);

  Future<void> _login(context) async {
    Map<String, dynamic> data = {
      'Username': name.text,
      'Password': password.text,
    };

    try {
      final response = await dio.post('$baseurl/login', data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
         loginid = response.data['login_id'];
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Homepage(),)
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Student Login"),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Form(
                key: key,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 🎓 Logo / Icon
                    const CircleAvatar(
                      radius: 34,
                      backgroundColor: primaryColor,
                      child: Icon(
                        Icons.school_outlined,
                        color: Colors.white,
                        size: 34,
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      "Login to continue",
                      style: TextStyle(fontSize: 14, color: subTextColor),
                    ),

                    const SizedBox(height: 24),

                    // 👤 Username
                    TextFormField(
                      controller: name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Username',
                        prefixIcon: const Icon(Icons.person_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // 🔑 Password
                    TextFormField(
                      controller: password,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 26),

                    // 🔘 Login Button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (key.currentState!.validate()) {
                            // Navigate to dashboard/home
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Homepage(),
                              ),
                              (route) => false,
                            );
                          }
                        },
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "New student?",
                          style: TextStyle(color: subTextColor),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => studentpage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Create Account",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
