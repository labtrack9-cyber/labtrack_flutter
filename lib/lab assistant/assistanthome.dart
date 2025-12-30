import 'package:flutter/material.dart';
import 'package:labtrack/lab assistant/assigntask.dart';
import 'package:labtrack/lab assistant/labreport.dart';
import 'package:labtrack/lab assistant/sendnotification.dart';
import 'package:labtrack/lab assistant/viewstudents.dart';
import 'package:labtrack/lab%20assistant/classtask.dart';
import 'package:labtrack/lab%20assistant/labassistantprofile.dart';
import 'package:labtrack/student/login.dart';

class LabAssistantHomePage extends StatefulWidget {
  const LabAssistantHomePage({super.key});

  @override
  State<LabAssistantHomePage> createState() => _LabAssistantHomePageState();
}

class _LabAssistantHomePageState extends State<LabAssistantHomePage> {
  int _currentIndex = 0;

  // 🎨 Color Theme
  static const Color baseTeal = Color(0xFF008080);
  static final Color lightTeal = baseTeal.withOpacity(0.1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightTeal,

      // 🔹 APP BAR
      appBar: AppBar(
        backgroundColor: baseTeal,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "LabTrack",
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
        ),
      ),

      // 🔹 BODY (HOME DASHBOARD)
      body: Column(
        children: [
          // 🔹 HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: baseTeal,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome 👋",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 6),
                Text(
                  "Lab Assistant Dashboard",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // 🔹 GRID MENU
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _menuCard(
                    icon: Icons.assignment,
                    title: "Assign Task to Students",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AssignTaskPage(),
                        ),
                      );
                    },
                  ),
                   _menuCard(
                    icon: Icons.assignment,
                    title: "Assign Task to Class",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AssignTaskToClassPage(),
                        ),
                      );
                    },
                  ),
                  _menuCard(
                    icon: Icons.note_add,
                    title: "Add Lab Report",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ManageReportsPage(),
                        ),
                      );
                    },
                  ),
                  _menuCard(
                    icon: Icons.notifications_active,
                    title: "Send Notification",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SendNotificationPage(),
                        ),
                      );
                    },
                  ),
                  _menuCard(
                    icon: Icons.group,
                    title: "Class and Students",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ViewStudentsClassesPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // 🔹 BOTTOM NAVIGATION BAR
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: baseTeal,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            setState(() => _currentIndex = 0);
          } 
          else if (index == 1) {
            // PROFILE (simple placeholder)
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const Assistantprofile(),
              ),
            );
          } 
          else if (index == 2) {
            // LOGOUT
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LabAssistantHomePage()),
              (route) => false,
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: "Logout",
          ),
        ],
      ),
    );
  }

  // 🔹 MENU CARD
  Widget _menuCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        elevation: 4,
        shadowColor: baseTeal.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: baseTeal.withOpacity(0.15),
              child: Icon(icon, size: 34, color: baseTeal),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🔹 SIMPLE PROFILE PAGE
class LabAssistantProfilePage extends StatelessWidget {
  const LabAssistantProfilePage({super.key});

  static const Color baseTeal = Color(0xFF008080);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: baseTeal,
        title: const Text("Profile"),
      ),
      body: const Center(
        child: Text(
          "Lab Assistant Profile",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
