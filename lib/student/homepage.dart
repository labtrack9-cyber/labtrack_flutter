import 'package:flutter/material.dart';
import 'package:labtrack/student/complaint.dart';
import 'package:labtrack/student/feedback.dart';
import 'package:labtrack/student/report.dart';
import 'package:labtrack/student/viewassignedlab.dart';
import 'package:labtrack/student/viewtask.dart';

// ================= COLORS =================
const Color primaryColor = Color(0xFF1E3A8A);
const Color backgroundColor = Color(0xFFF8FAFC);
const Color textColor = Color(0xFF111827);

// ================= MAIN =================
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LabTrack',
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        primaryColor: primaryColor,
      ),
      home: const Homepage(),
    );
  }
}

// ================= HOMEPAGE =================
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() => _currentIndex = index);
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
        ],
      ),
    );
  }
}

// ================= HOME SCREEN =================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PROFILE CARD
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 8)
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: primaryColor,
                    child: const Icon(Icons.person,
                        color: Colors.white, size: 36),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Hello, Student 👋",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor),
                      ),
                      SizedBox(height: 6),
                      Text("Admission No: 123456",
                          style: TextStyle(color: Colors.grey)),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Quick Actions",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: textColor),
            ),

            const SizedBox(height: 16),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: features.length,
              itemBuilder: (context, index) {
                return FeatureCard(feature: features[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ================= FEATURE MODEL =================
class Feature {
  final IconData icon;
  final String title;
  final Widget page;

  Feature({required this.icon, required this.title, required this.page});
}

final List<Feature> features = [
  Feature(icon: Icons.report, title: "View Report", page: ViewReportPage()),
  Feature(icon: Icons.task, title: "View Tasks", page: Viewtask()),
  Feature(
      icon: Icons.room_preferences,
      title: "Assigned Lab",
      page: AssignedLabPage()),
  Feature(icon: Icons.feedback, title: "Feedback", page: FeedbackPage()),
  Feature(
      icon: Icons.warning_amber_rounded,
      title: "Complaints",
      page: ComplaintPage()),
  // Feature(icon: Icons.reply, title: "View Reply", page: repl()),
];

// ================= FEATURE CARD =================
class FeatureCard extends StatelessWidget {
  final Feature feature;

  const FeatureCard({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => feature.page),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 6)
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: primaryColor.withOpacity(0.1),
              child: Icon(feature.icon, color: primaryColor),
            ),
            const SizedBox(height: 10),
            Text(feature.title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13, color: textColor)),
          ],
        ),
      ),
    );
  }
}

// ================= COMMON PAGE UI =================
class CommonPage extends StatelessWidget {
  final String title;

  const CommonPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: primaryColor,
      ),
      body: Center(
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: textColor),
        ),
      ),
    );
  }
}

// ================= PROFILE SCREEN =================
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Profile Screen",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor)),
    );
  }
}
