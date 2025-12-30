import 'package:flutter/material.dart';

class Assistantprofile extends StatelessWidget {
  const Assistantprofile({super.key});

  // 🎨 Same Theme Colors
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
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔹 PROFILE HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: const BoxDecoration(
                color: baseTeal,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: baseTeal,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Lab Assistant",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Computer Science Lab",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 PROFILE DETAILS CARD
            _infoCard(
              icon: Icons.badge,
              title: "Employee ID",
              value: "LAB-1023",
            ),
            _infoCard(
              icon: Icons.email,
              title: "Email",
              value: "labassistant@gmail.com",
            ),
            _infoCard(
              icon: Icons.phone,
              title: "Phone",
              value: "+91 98765 43210",
            ),
            _infoCard(
              icon: Icons.schedule,
              title: "Shift",
              value: "9:00 AM - 4:00 PM",
            ),

            const SizedBox(height: 20),

            // 🔹 ACTION BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: baseTeal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.edit, color: Colors.white),
                  label: const Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    // TODO: Navigate to Edit Profile
                  },
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // 🔹 REUSABLE INFO CARD
  static Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: baseTeal.withOpacity(0.15),
            child: Icon(icon, color: baseTeal),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(value),
        ),
      ),
    );
  }
}
