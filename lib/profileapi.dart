import 'package:dio/dio.dart';
import 'package:labtrack/student/login.dart';

final Dio dio = Dio();

Map<String, dynamic> studentProfile = {};

/// 🔹 Fetch profile
Future<Map<String, dynamic>> getProfileApi() async {
  try {
    final response = await dio.get('$baseurl/profile/$loginid');

    if (response.statusCode == 200) {
      studentProfile = response.data;
      return studentProfile;
    }
  } catch (e) {
    print("PROFILE API ERROR: $e");
  }
  return {};
}

/// 🔹 Helper getter (for name)
String get studentName {
  return studentProfile['name'] ?? '';
}
