import 'package:flutter/material.dart';
import 'package:labtrack/student/complaint.dart';
import 'package:labtrack/student/feedback.dart';
import 'package:labtrack/student/report.dart';
import 'package:labtrack/student/viewassignedlab.dart';
import 'package:labtrack/student/viewtask.dart';
import 'package:labtrack/student/profile.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

const Color primaryColor = Color(0xFF1E3A8A);
const Color backgroundColor = Color(0xFFF8FAFC);
const Color textColor = Color(0xFF111827);

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;

  // 🔹 Screens for bottom nav
  final List<Widget> _screens = [
    const HomeScreen(),    // Custom Home Screen (features grid)
    Profile()      // Profile screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: _screens[_currentIndex],  // Switch screens based on selected tab
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.task),
          //   label: "Tasks",
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

// 🔹 Home Screen with Feature Grid
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // 👤 Profile Card
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: primaryColor,
                    child: Icon(Icons.person, color: Colors.white, size: 32),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello, Student!",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Admission No: 123456",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // 🔹 Features Grid
          GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _featureItem(context, Icons.report, "View Report"),
              _featureItem(context, Icons.task, "View Tasks"),
              _featureItem(context, Icons.room_preferences, "Assigned Lab"),
              _featureItem(context, Icons.feedback, "Feedback"),
              _featureItem(context, Icons.warning_amber_rounded, "Complaints"),
              _featureItem(context, Icons.reply, "View Reply"),
            ],
          ),
        ],
      ),
    );
  }
}

// 🔹 Feature Item Widget
Widget _featureItem(BuildContext context, IconData icon, String label) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    elevation: 2,
    child: InkWell(
      onTap: () {
        switch (label) {
          case "View Report":
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ViewReportPage()));
            break;
          case "View Tasks":
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Viewtask()));
            break;
          case "Assigned Lab":
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>  AssignedLabPage()));
            break;
          case "Feedback":
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => FeedbackPage()));
            break;
          case "Complaints":
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ComplaintPage()));
            break;
          case "View Reply":
            // TODO: Implement view reply
            break;
        }
      },
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 24,
              child: Icon(icon, color: primaryColor, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: textColor),
            ),
          ],
        ),
      ),
    ),
  );
}
