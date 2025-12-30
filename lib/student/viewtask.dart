import 'package:flutter/material.dart';

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
  List<Map<String, dynamic>> tasks = [
    {"title": "Math Assignment", "completed": true, "remark": "Excellent work"},
    {"title": "Science Project", "completed": false, "remark": ""},
    {"title": "English Essay", "completed": true, "remark": "Good, improve grammar"},
  ];

  int get completedCount => tasks.where((t) => t["completed"] == true).length;

  double get progress => tasks.isEmpty ? 0 : completedCount / tasks.length;

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
        child: Column(
          children: [
            // 🔹 Progress Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Overall Progress",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: progress,
                              minHeight: 12,
                              backgroundColor: Colors.grey.shade300,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "${(progress * 100).toInt()}%",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "$completedCount of ${tasks.length} tasks completed",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 🔹 Task List
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  final bool completed = task["completed"];

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
                      leading: CircleAvatar(
                        radius: 24,
                        backgroundColor: completed
                            ? primaryColor.withOpacity(0.15)
                            : Colors.orange.withOpacity(0.15),
                        child: Icon(
                          completed ? Icons.check : Icons.pending_actions,
                          color: completed ? primaryColor : Colors.orange,
                        ),
                      ),
                      title: Text(
                        task["title"],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      subtitle: completed
                          ? Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                "Remark: ${task["remark"]}",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            )
                          : const Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Text(
                                "Pending",
                                style: TextStyle(
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
