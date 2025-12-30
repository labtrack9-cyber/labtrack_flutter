import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color baseTeal = Color(0xFF008080);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Manage Reports',
      theme: ThemeData(
        primaryColor: baseTeal,
        colorScheme: ColorScheme.fromSeed(seedColor: baseTeal),
        useMaterial3: true,
      ),
      home: const ManageReportsPage(),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                               SAMPLE DATA                                  */
/* -------------------------------------------------------------------------- */

final Map<String, List<String>> classStudents = {
  "Class 8 - A": ["Alice Johnson", "Bob Smith"],
  "Class 8 - B": ["Charlie Brown"],
  "Class 9 - A": ["Diana Prince"],
};

final Map<String, List<Map<String, dynamic>>> studentReports = {
  "Alice Johnson": [
    {"report": "Physics Lab 1", "completed": false},
  ],
  "Bob Smith": [
    {"report": "Chemistry Lab 2", "completed": true},
  ],
  "Charlie Brown": [
    {"report": "Biology Lab 3", "completed": false},
  ],
  "Diana Prince": [
    {"report": "Physics Lab 2", "completed": true},
  ],
};

/* -------------------------------------------------------------------------- */
/*                          MANAGE REPORTS PAGE                                */
/* -------------------------------------------------------------------------- */

class ManageReportsPage extends StatefulWidget {
  const ManageReportsPage({super.key});

  @override
  State<ManageReportsPage> createState() => _ManageReportsPageState();
}

class _ManageReportsPageState extends State<ManageReportsPage> {
  static const Color baseTeal = Color(0xFF008080);
  static final Color lightTeal = baseTeal.withOpacity(0.1);

  String? selectedClass;

  @override
  Widget build(BuildContext context) {
    final students =
        selectedClass == null ? [] : classStudents[selectedClass]!;

    return Scaffold(
      backgroundColor: lightTeal,
      appBar: AppBar(
        backgroundColor: baseTeal,
        centerTitle: true,
        title: const Text(
          "Manage Reports",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// CLASS DROPDOWN
            DropdownButtonFormField<String>(
              value: selectedClass,
              decoration: InputDecoration(
                hintText: "Select Class",
                prefixIcon: const Icon(Icons.groups, color: baseTeal),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: classStudents.keys
                  .map(
                    (cls) => DropdownMenuItem(
                      value: cls,
                      child: Text(cls),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedClass = value;
                });
              },
            ),
            const SizedBox(height: 20),

            /// STUDENTS LIST
            Expanded(
              child: students.isEmpty
                  ? const Center(
                      child: Text(
                        "Select a class to view students",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final student = students[index];

                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ListTile(
                            leading:
                                const Icon(Icons.person, color: baseTeal),
                            title: Text(
                              student,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => StudentReportsPage(
                                    studentName: student,
                                  ),
                                ),
                              );
                            },
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

/* -------------------------------------------------------------------------- */
/*                         STUDENT REPORT PAGE                                 */
/* -------------------------------------------------------------------------- */

class StudentReportsPage extends StatefulWidget {
  final String studentName;

  const StudentReportsPage({super.key, required this.studentName});

  @override
  State<StudentReportsPage> createState() => _StudentReportsPageState();
}

class _StudentReportsPageState extends State<StudentReportsPage> {
  static const Color baseTeal = Color(0xFF008080);
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    final reports = studentReports[widget.studentName]!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: baseTeal,
        title: Text(
          widget.studentName,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isEditing ? Icons.save : Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
              });

              if (!isEditing) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Reports saved successfully"),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: reports.length,
        itemBuilder: (context, index) {
          final report = reports[index];

          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    report["report"],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text("Completed: "),
                      Checkbox(
                        value: report["completed"],
                        activeColor: baseTeal,
                        onChanged: isEditing
                            ? (value) {
                                setState(() {
                                  report["completed"] = value;
                                });
                              }
                            : null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
