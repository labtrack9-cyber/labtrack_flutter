import 'package:flutter/material.dart';

class ViewAssignedLabPage extends StatelessWidget {
  const ViewAssignedLabPage({super.key});

  // 🎨 Same Theme
  static const Color baseTeal = Color(0xFF008080);
  static final Color lightTeal = baseTeal.withOpacity(0.1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightTeal,

      // 🔹 APP BAR
      appBar: AppBar(
        backgroundColor: baseTeal,
        title: const Text(
          "Assigned Lab",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _labCard(
              labName: "Computer Lab - 1",
              day: "Monday",
              time: "10:00 AM - 12:00 PM",
              status: "Active",
            ),
            _labCard(
              labName: "Networking Lab",
              day: "Wednesday",
              time: "1:00 PM - 3:00 PM",
              status: "Upcoming",
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 LAB ASSIGNMENT CARD
  Widget _labCard({
    required String labName,
    required String day,
    required String time,
    required String status,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LAB NAME
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: baseTeal.withOpacity(0.15),
                  child: const Icon(Icons.computer, color: baseTeal),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    labName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // DAY
            _infoRow(Icons.calendar_today, "Day", day),

            const SizedBox(height: 8),

            // TIME
            _infoRow(Icons.access_time, "Time", time),

            const SizedBox(height: 12),

            // STATUS
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: status == "Active"
                      ? Colors.green.withOpacity(0.15)
                      : Colors.orange.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: status == "Active"
                        ? Colors.green
                        : Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 INFO ROW
  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: baseTeal),
        const SizedBox(width: 8),
        Text(
          "$label : ",
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
