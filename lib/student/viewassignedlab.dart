import 'package:flutter/material.dart';
import 'package:labtrack/student/login.dart';
import 'package:intl/intl.dart';

// 🎓 Theme colors
const Color primaryColor = Color(0xFF1E3A8A);
const Color backgroundColor = Color(0xFFF8FAFC);
const Color textColor = Color(0xFF111827);

class AssignedLabPage extends StatefulWidget {
  const AssignedLabPage({super.key});

  @override
  State<AssignedLabPage> createState() => _AssignedLabPageState();
}

class _AssignedLabPageState extends State<AssignedLabPage> {
  List<dynamic> labs = [];

  /// 🔹 Fetch assigned labs
  Future<void> getlabs(BuildContext context) async {
    try {
      final response = await dio.get('$baseurl/assignedlab/$loginid');

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          labs = response.data;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something went wrong')),
      );
    }
  }

  /// 🔹 Format API DateTime
  String formatDateTime(String? apiTime) {
    if (apiTime == null || apiTime.isEmpty) {
      return 'Not scheduled';
    }

    try {
      final dateTime = DateTime.parse(apiTime).toLocal();
      return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
    } catch (e) {
      return 'Invalid date';
    }
  }

  @override
  void initState() {
    super.initState();
    getlabs(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Assigned Labs"),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: labs.isEmpty
            ? Center(
                child: Text(
                  "No labs assigned yet",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: labs.length,
                itemBuilder: (context, index) {
                  final lab = labs[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// 🔹 Lab Name
                          Text(
                            lab["lab_name"] ?? 'Unknown Lab',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),

                          const SizedBox(height: 10),

                          /// 🔹 Lab Assistant
                          Row(
                            children: [
                              const Icon(
                                Icons.person_outline,
                                size: 18,
                                color: primaryColor,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                lab["labassistant_name"] ??
                                    'Assistant not assigned',
                                style:
                                    const TextStyle(color: textColor),
                              ),
                            ],
                          ),

                          const SizedBox(height: 6),

                          /// 🔹 Time
                          Row(
                            children: [
                              const Icon(
                                Icons.schedule,
                                size: 18,
                                color: primaryColor,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                formatDateTime(lab["time"]),
                                style:
                                    const TextStyle(color: textColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
