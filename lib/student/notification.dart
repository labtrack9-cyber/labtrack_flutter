import 'package:flutter/material.dart';

// 🎓 Theme colors
const Color primaryColor = Color(0xFF1E3A8A);
const Color backgroundColor = Color(0xFFF8FAFC);
const Color textColor = Color(0xFF111827);

class NotificationsPage extends StatelessWidget {
  NotificationsPage({super.key});

  // Sample notifications data
  final List<Map<String, String>> notifications = [
    {
      "title": "Lab Schedule Updated",
      "description": "Physics Lab timing has been moved to Monday 11:00 AM.",
      "time": "1 hour ago"
    },
    {
      "title": "New Assignment",
      "description": "Math Assignment 5 has been uploaded on LMS.",
      "time": "Yesterday"
    },
    {
      "title": "Feedback Reminder",
      "description": "Please submit your feedback for the Chemistry Lab.",
      "time": "2 days ago"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: notifications.isEmpty
            ? Center(
                child: Text(
                  "No notifications available",
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
              )
            : ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notif = notifications[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: CircleAvatar(
                        radius: 24,
                        backgroundColor: primaryColor.withOpacity(0.1),
                        child: Icon(Icons.notifications, color: primaryColor),
                      ),
                      title: Text(
                        notif["title"]!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 6),
                          Text(
                            notif["description"]!,
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            notif["time"]!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
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
