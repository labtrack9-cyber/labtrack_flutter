import 'package:flutter/material.dart';
import 'package:labtrack/student/login.dart';
import 'package:intl/intl.dart'; // <-- for date formatting

// 🎓 Theme colors
const Color primaryColor = Color(0xFF1E3A8A);
const Color backgroundColor = Color(0xFFF8FAFC);
const Color textColor = Color(0xFF111827);

class Viewtask extends StatefulWidget {
  const Viewtask({super.key});

  @override
  State<Viewtask> createState() => _ViewtaskState();
}

class _ViewtaskState extends State<Viewtask> {
  List<Map<String, dynamic>> tasks = [];

  Future<void> gettasks(BuildContext context) async {
    try {
      final response = await dio.get('$baseurl/task/$loginid');
      print(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          tasks = List<Map<String, dynamic>>.from(response.data);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  /// Format date string to dd MMM yyyy
  String formatDate(String? date) {
    if (date == null || date.isEmpty) return 'No due date';
    try {
      final dt = DateTime.parse(date);
      return DateFormat('dd MMM yyyy').format(dt);
    } catch (e) {
      return 'Invalid date';
    }
  }

  @override
  void initState() {
    super.initState();
    gettasks(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("View Tasks"),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: tasks.isEmpty
            ? Center(
                child: Text(
                  "No tasks assigned yet",
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
              )
            : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 2,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      leading: const Icon(Icons.science, color: primaryColor),
                      title: Text(
                        task["experiment"] ?? 'No experiment name',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Status: ${task["status"] ?? 'Pending'}",
                              style: TextStyle(
                                color: task["status"] != null
                                    ? Colors.green
                                    : Colors.redAccent,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Due Date: ${formatDate(task["duedate"])}",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
