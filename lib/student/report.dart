// import 'package:flutter/material.dart';

// class ViewReportPage extends StatefulWidget {
//   const ViewReportPage({super.key});

//   @override
//   State<ViewReportPage> createState() => _ViewReportPageState();
// }

// class _ViewReportPageState extends State<ViewReportPage> {
//   // Example report data
//   List<Map<String, dynamic>> reports = [
//     {"title": "Math Assignment", "completed": true},
//     {"title": "Science Project", "completed": false},
//     {"title": "English Essay", "completed": true},
//     {"title": "History Quiz", "completed": false},
//   ];

//   int get completedCount =>
//       reports.where((r) => r["completed"] == true).length;

//   double get progress => reports.isEmpty ? 0 : completedCount / reports.length;

//   static const Color primaryColor = Color(0xFF1E3A8A);
//   static const Color backgroundColor = Color(0xFFF8FAFC);
//   static const Color textColor = Color.fromARGB(255, 230, 231, 233);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         title: const Text("Report"),
//         centerTitle: true,
//         backgroundColor: primaryColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // 🔹 Progress Card
//             Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               elevation: 3,
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Overall Progress",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: LinearProgressIndicator(
//                               value: progress,
//                               minHeight: 12,
//                               backgroundColor: Colors.grey.shade300,
//                               color: primaryColor,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Text(
//                           "${(progress * 100).toInt()}%",
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       "$completedCount of ${reports.length} tasks completed",
//                       style: TextStyle(
//                         color: Colors.grey.shade700,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),

//             // 🔹 Individual Task Progress
//             Expanded(
//               child: ListView.builder(
//                 itemCount: reports.length,
//                 itemBuilder: (context, index) {
//                   final task = reports[index];
//                   final bool completed = task["completed"];

//                   return Card(
//                     margin: const EdgeInsets.only(bottom: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                     elevation: 2,
//                     child: ListTile(
//                       contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 12),
//                       leading: CircleAvatar(
//                         radius: 22,
//                         backgroundColor: completed
//                             ? Colors.green.withOpacity(0.15)
//                             : Colors.orange.withOpacity(0.15),
//                         child: Icon(
//                           completed ? Icons.check : Icons.pending_actions,
//                           color: completed ? Colors.green : Colors.orange,
//                         ),
//                       ),
//                       title: Text(
//                         task["title"],
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       subtitle: completed
//                           ? const Padding(
//                               padding: EdgeInsets.only(top: 6),
//                               child: Text(
//                                 "Completed",
//                                 style: TextStyle(color: Colors.green),
//                               ),
//                             )
//                           : const Padding(
//                               padding: EdgeInsets.only(top: 6),
//                               child: Text(
//                                 "Pending",
//                                 style: TextStyle(color: Colors.redAccent),
//                               ),
//                             ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:labtrack/student/login.dart';

final Dio dio = Dio();



class ViewReportPage extends StatefulWidget {
  const ViewReportPage({super.key});

  @override
  State<ViewReportPage> createState() => _ViewReportPageState();
}

class _ViewReportPageState extends State<ViewReportPage> {
  List<Map<String, dynamic>> reports = [];
  bool isLoading = true;

  static const Color primaryColor = Color(0xFF1E3A8A);
  static const Color backgroundColor = Color(0xFFF8FAFC);

  @override
  void initState() {
    super.initState();
    getTaskReport();
  }

  // ================= GET TASK REPORT API =================
  Future<void> getTaskReport() async {
    try {
      final response = await dio.get('$baseurl/task-report/$loginid/');
      print(response.data);

      if (response.statusCode == 200) {
        final List data = response.data;

        setState(() {
          reports = data.map<Map<String, dynamic>>((task) {
            return {
              "title": task["experiment"],
              "completed":
                  task["status"].toString().toLowerCase() == "completed",
            };
          }).toList();

          isLoading = false;
        });
      }
    } catch (e) {
      print("REPORT ERROR: $e");
      setState(() => isLoading = false);
    }
  }

  int get completedCount =>
      reports.where((r) => r["completed"] == true).length;

  double get progress =>
      reports.isEmpty ? 0 : completedCount / reports.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Report"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // 🔹 Progress Card
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Overall Progress",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
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
                                    backgroundColor:
                                        Colors.grey.shade300,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "${(progress * 100).toInt()}%",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "$completedCount of ${reports.length} tasks completed",
                            style:
                                TextStyle(color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 🔹 Task List
                  Expanded(
                    child: ListView.builder(
                      itemCount: reports.length,
                      itemBuilder: (context, index) {
                        final task = reports[index];
                        final bool completed = task["completed"];

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          elevation: 2,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: completed
                                  ? Colors.green.withOpacity(0.15)
                                  : Colors.orange.withOpacity(0.15),
                              child: Icon(
                                completed
                                    ? Icons.check
                                    : Icons.pending_actions,
                                color: completed
                                    ? Colors.green
                                    : Colors.orange,
                              ),
                            ),
                            title: Text(
                              task["title"],
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              completed ? "Completed" : "Pending",
                              style: TextStyle(
                                  color: completed
                                      ? Colors.green
                                      : Colors.redAccent),
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
