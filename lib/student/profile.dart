import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'login.dart';

final Dio dio = Dio();

String studentName = "";


// 🔗 CHANGE THIS

const Color primaryColor = Color(0xFF1E3A8A);
const Color backgroundColor = Color(0xFFF8FAFC);
const Color textColor = Color(0xFF111827);

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map<String, dynamic> profile = {};
  bool isLoading = true;

  late TextEditingController nameCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController admissionCtrl;
  late TextEditingController programCtrl;
  late TextEditingController semesterCtrl;
  late TextEditingController mobileCtrl;
  late TextEditingController dobCtrl;
  late TextEditingController genderCtrl;

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  // ================= GET PROFILE =================
  Future<void> getProfile() async {
    try {
      final response = await dio.get('$baseurl/profile/$loginid');

      if (response.statusCode == 200) {
        profile = response.data;
        

        nameCtrl = TextEditingController(text: profile['name'] ?? '');
        emailCtrl = TextEditingController(text: profile['email'] ?? '');
        admissionCtrl = TextEditingController(
            text: profile['admissionno']?.toString() ?? '');
        programCtrl =
            TextEditingController(text: profile['program'] ?? '');
        semesterCtrl =
            TextEditingController(text: profile['semester'] ?? '');
        mobileCtrl =
            TextEditingController(text: profile['mobno']?.toString() ?? '');
        dobCtrl = TextEditingController(text: profile['dob'] ?? '');
        genderCtrl = TextEditingController(text: profile['gender'] ?? '');

        studentName=profile['name'];

        setState(() => isLoading = false);
      }
    } catch (e) {
      print("GET ERROR: $e");
    }
  }

  // ================= UPDATE PROFILE =================
  Future<void> updateProfile() async {
    try {
      final response = await dio.put(
        '$baseurl/profile/$loginid/',
        data: {
          "name": nameCtrl.text,
          "email": emailCtrl.text,
          "admissionno": admissionCtrl.text,
          "program": programCtrl.text,
          "semester": semesterCtrl.text,
          "mobno": mobileCtrl.text,
          "dob": dobCtrl.text,
          "gender": genderCtrl.text,
        },
      );

      if (response.statusCode == 200) {
        Navigator.pop(context);
        getProfile();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile updated successfully")),
        );
      }
    } catch (e) {
      print("UPDATE ERROR: $e");
    }
  }

  // ================= EDIT DIALOG =================
  void editProfileDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                buildEditField("Name", nameCtrl),
                buildEditField("Email", emailCtrl),
                buildEditField("Admission No", admissionCtrl),
                buildEditField("Program", programCtrl),
                buildEditField("Semester", semesterCtrl),
                buildEditField("Mobile", mobileCtrl),
                buildEditField("DOB", dobCtrl),
                buildEditField("Gender", genderCtrl),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: updateProfile,
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.person, size: 50),
                  ),
                  const SizedBox(height: 10),
                  Text(profile['name'] ?? '',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(profile['email'] ?? '',
                      style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 20),

                  Card(
                    child: Column(
                      children: [
                        buildRow("Admission No", profile['admissionno']),
                        buildRow("Program", profile['program']),
                        buildRow("Semester", profile['semester']),
                        buildRow("Mobile", profile['mobno']),
                        buildRow("DOB", profile['dob']),
                        buildRow("Gender", profile['gender']),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: editProfileDialog,
                      child: const Text("Edit Profile"),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildRow(String label, dynamic value) {
    return ListTile(
      title: Text(label),
      trailing: Text(value?.toString() ?? ''),
    );
  }

  Widget buildEditField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
