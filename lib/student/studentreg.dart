import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:labtrack/student/login.dart';

String baseurl='http://192.168.1.150:8000';
Dio dio=Dio();

class studentpage extends StatelessWidget {
  studentpage({super.key});

  final TextEditingController name = TextEditingController();
  final TextEditingController admission = TextEditingController();
  final TextEditingController program = TextEditingController();
  final TextEditingController semester = TextEditingController();
  final TextEditingController mob = TextEditingController();
  final TextEditingController dob = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  // 🎓 Same theme colors as Login
  static const Color primaryColor = Color(0xFF1E3A8A);
  static const Color backgroundColor = Color(0xFFF8FAFC);
  static const Color textColor = Color(0xFF111827);

 // simple registeration function
  Future<void>_register(context) async{
   Map<String, dynamic>data = {
    'name':name.text,
    'admissionno':admission.text,
    'program':program.text,
    'semester':semester.text,
    'mobno':mob.text,
    'dob':dob.text,
    'gender':gender.text,
    'email':email.text,
    'password':password.text,
    'username':email.text
  
   };
   print(data);
   try {
     final response = await dio.post('$baseurl/userreg',data: data);
     if (response.statusCode==200||response.statusCode==201){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
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
        title: const Text("Student Registration"),
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
                key: _key,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    const Text(
                      "Create Student Account",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),

                    const SizedBox(height: 20),

                    _buildField(name, "Name", Icons.person),
                    _buildField(admission, "Admission No", Icons.badge),
                    _buildField(program, "Program", Icons.school),
                    _buildField(semester, "Semester", Icons.calendar_today),
                    _buildField(mob, "Mobile Number", Icons.phone),
                    _buildField(dob, "Date of Birth", Icons.cake),
                    _buildField(gender, "Gender", Icons.people),
                    _buildField(email, "Email", Icons.email),
                    _buildField(password, "Password", Icons.lock,
                        obscure: true),

                    const SizedBox(height: 26),

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
                          if (_key.currentState!.validate()) {
                           _register(context);
                          }
                        },
                        child: const Text(
                          "REGISTER",
                          style: TextStyle(
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Reusable Field Widget (Clean & Consistent)
  Widget _buildField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool obscure = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "$label required";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primaryColor),
          ),
        ),
      ),
    );
  }
}
