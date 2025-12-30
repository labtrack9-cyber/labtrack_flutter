import 'package:flutter/material.dart';

// 🎓 Theme colors
const Color primaryColor = Color(0xFF1E3A8A);
const Color backgroundColor = Color(0xFFF8FAFC);
const Color textColor = Color(0xFF111827);

class AssignedLabPage extends StatelessWidget {
  AssignedLabPage({super.key});

  // Sample assigned lab data
  final List<Map<String, String>> labs = [
    {"labName": "Physics Lab", "labInstructor": "Dr. John Doe", "schedule": "Mon 10:00-12:00"},
    {"labName": "Chemistry Lab", "labInstructor": "Dr. Jane Smith", "schedule": "Wed 14:00-16:00"},
    {"labName": "Computer Lab", "labInstructor": "Mr. Alan Turing", "schedule": "Fri 09:00-11:00"},
  ];

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
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
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
                          Text(
                            lab["labName"]!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.person_outline, size: 18, color: primaryColor),
                              const SizedBox(width: 6),
                              Text(
                                lab["labInstructor"]!,
                                style: const TextStyle(color: textColor),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.schedule, size: 18, color: primaryColor),
                              const SizedBox(width: 6),
                              Text(
                                lab["schedule"]!,
                                style: const TextStyle(color: textColor),
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
