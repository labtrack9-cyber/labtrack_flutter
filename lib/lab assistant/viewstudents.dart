import 'package:flutter/material.dart';

class ViewStudentsClassesPage extends StatefulWidget {
  const ViewStudentsClassesPage({super.key});

  @override
  State<ViewStudentsClassesPage> createState() =>
      _ViewStudentsClassesPageState();
}

class _ViewStudentsClassesPageState extends State<ViewStudentsClassesPage> {
  // 🎨 Theme
  static const Color baseTeal = Color(0xFF008080);
  static final Color lightTeal = baseTeal.withOpacity(0.1);

  // 🔹 Dummy class & student data
  final Map<String, List<String>> classStudents = {
    "BSc CS – Lab A": [
      "Alice Johnson",
      "Bob Smith",
      "Charlie Brown",
    ],
    "BSc CS – Lab B": [
      "Diana Prince",
      "Ethan Hunt",
    ],
    "BCA – Lab A": [
      "Frank Castle",
      "Grace Lee",
    ],
  };

  String? selectedClass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightTeal,

      // 🔹 APP BAR
      appBar: AppBar(
        backgroundColor: baseTeal,
        centerTitle: true,
        title: const Text(
          "Students & Classes",
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
        ),
      ),

      body: Column(
        children: [
          // 🔹 CLASS DROPDOWN
          Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButtonFormField<String>(
              value: selectedClass,
              decoration: InputDecoration(
                labelText: "Select Class",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.class_),
              ),
              items: classStudents.keys
                  .map(
                    (className) => DropdownMenuItem(
                      value: className,
                      child: Text(className),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedClass = value;
                });
              },
            ),
          ),

          // 🔹 STUDENT LIST
          Expanded(
            child: selectedClass == null
                ? const Center(
                    child: Text(
                      "Select a class to view students",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: classStudents[selectedClass]!.length,
                    itemBuilder: (context, index) {
                      final student =
                          classStudents[selectedClass]![index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                baseTeal.withOpacity(0.2),
                            child: const Icon(
                              Icons.person,
                              color: baseTeal,
                            ),
                          ),
                          title: Text(
                            student,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
