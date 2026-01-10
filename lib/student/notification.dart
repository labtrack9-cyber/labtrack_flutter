// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:labtrack/student/login.dart';

// // 🎓 Theme colors
// const Color primaryColor = Color(0xFF1E3A8A);
// const Color backgroundColor = Color(0xFFF8FAFC);
// const Color textColor = Color(0xFF111827);

// class NotificationsPage extends StatefulWidget {
//   const NotificationsPage({super.key});

//   @override
//   State<NotificationsPage> createState() => _NotificationsPageState();
// }

// class _NotificationsPageState extends State<NotificationsPage> {
//   late Future<List<Map<String, dynamic>>> notificationsFuture;

//   final Dio dio = Dio();

//   @override
//   void initState() {
//     super.initState();
//     notificationsFuture = getNotifications();
//   }

//   // ----------------------------
//   // GET Notifications using DIO
//   // ----------------------------
//   Future<List<Map<String, dynamic>>> getNotifications() async {
//      String apiUrl =
//         "$baseurl/notification/$loginid"; // 🔁 change URL

//     try {
//       final response = await dio.get(apiUrl);
//       print(response)
//       if (response.statusCode == 200) {
//         final List data = response.data;
//         print(data);
//         return data.cast<Map<String, dynamic>>();
//       } else {
//         throw Exception("Failed to load notifications");
//       }
//     } catch (e) {
//       throw Exception("Error: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         title: const Text("Notifications"),
//         centerTitle: true,
//         backgroundColor: primaryColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: FutureBuilder<List<Map<String, dynamic>>>(
//           future: notificationsFuture,
//           builder: (context, snapshot) {
//             // Loading
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             // Error
//             if (snapshot.hasError) {
//               return const Center(
//                 child: Text(
//                   "Failed to load notifications",
//                   style: TextStyle(color: Colors.red),
//                 ),
//               );
//             }

//             final notifications = snapshot.data ?? [];

//             // Empty State
//             if (notifications.isEmpty) {
//               return Center(
//                 child: Text(
//                   "No notifications available",
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//               );
//             }

//             // Notifications List
//             return RefreshIndicator(
//               onRefresh: () async {
//                 setState(() {
//                   notificationsFuture = getNotifications();
//                 });
//               },
//               child: ListView.builder(
//                 itemCount: notifications.length,
//                 itemBuilder: (context, index) {
//                   final notif = notifications[index];

//                   return Card(
//                     margin: const EdgeInsets.only(bottom: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     elevation: 3,
//                     child: ListTile(
//                       contentPadding: const EdgeInsets.all(16),
//                       leading: CircleAvatar(
//                         radius: 24,
//                         backgroundColor: primaryColor.withOpacity(0.1),
//                         child: const Icon(
//                           Icons.notifications,
//                           color: primaryColor,
//                         ),
//                       ),
//                       title: Text(
//                         notif['title'] ?? '',
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: textColor,
//                         ),
//                       ),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const SizedBox(height: 6),
//                           Text(
//                             notif['description'] ?? '',
//                             style: TextStyle(
//                               color: Colors.grey.shade700,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             notif['time'] ?? '',
//                             style: const TextStyle(
//                               fontSize: 12,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:labtrack/student/login.dart';

// 🎓 Theme colors
const Color primaryColor = Color(0xFF1E3A8A);
const Color backgroundColor = Color(0xFFF8FAFC);
const Color textColor = Color(0xFF111827);

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late Future<List<Map<String, dynamic>>> notificationsFuture;
  final Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    notificationsFuture = getNotifications();
  }

  // ----------------------------
  // GET Notifications using DIO
  // ----------------------------
  Future<List<Map<String, dynamic>>> getNotifications() async {
    String apiUrl = "$baseurl/notification/$loginid";

    try {
      final response = await dio.get(apiUrl);
      print("API RESPONSE: ${response.data}");

      if (response.statusCode == 200) {
        final List data = response.data;
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception("Failed to load notifications");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: notificationsFuture,
          builder: (context, snapshot) {
            // Loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // Error
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "Failed to load notifications",
                  style: TextStyle(color: Colors.red),
                ),
              );
            }

            final notifications = snapshot.data ?? [];

            // Empty State
            if (notifications.isEmpty) {
              return Center(
                child: Text(
                  "No notifications available",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
              );
            }

            // Notifications List
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  notificationsFuture = getNotifications();
                });
              },
              child: ListView.builder(
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
                        child: const Icon(
                          Icons.notifications,
                          color: primaryColor,
                        ),
                      ),
                      title: Text(
                        notif['subject'] ?? '',
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
                            notif['notificationdetails'] ?? '',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Lab Assistant: ${notif['assistantname']}",
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
            );
          },
        ),
      ),
    );
  }
}
