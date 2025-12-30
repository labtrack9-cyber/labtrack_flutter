import 'package:flutter/material.dart';

class AssignTaskPage extends StatefulWidget {
  const AssignTaskPage({super.key});

  @override
  State<AssignTaskPage> createState() => _AssignTaskPageState();
}

class _AssignTaskPageState extends State<AssignTaskPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskDescController = TextEditingController();

  DateTime? dueDate;
  String? selectedClass;
  String? selectedStudent;

  // 🎓 Classes with students
  final Map<String, List<String>> classStudents = {
    "Class 6": ["Alice Johnson", "Bob Smith"],
    "Class 7": ["Charlie Brown", "Diana Prince"],
    "Class 8": ["Evan Stone", "Fiona Clark"],
  };

  // 🎨 Teal Theme
  static const Color baseTeal = Color(0xFF008080);
  static final Color lightTeal = baseTeal.withOpacity(0.1);

  Future<void> pickDueDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: baseTeal,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (date != null) {
      setState(() => dueDate = date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightTeal,
      appBar: AppBar(
        backgroundColor: baseTeal,
        centerTitle: true,
        title: const Text(
          "Assign Task",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shadowColor: baseTeal.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /// 🔹 Select Class
                  const Text(
                    "Select Class",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selectedClass,
                    decoration: _inputDecoration(Icons.class_),
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
                        selectedStudent = null;
                      });
                    },
                    validator: (value) =>
                        value == null ? "Select a class" : null,
                  ),

                  const SizedBox(height: 16),

                  /// 🔹 Select Student
                  const Text(
                    "Assign to Student",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selectedStudent,
                    decoration: _inputDecoration(Icons.person),
                    items: selectedClass == null
                        ? []
                        : classStudents[selectedClass]!
                            .map(
                              (student) => DropdownMenuItem(
                                value: student,
                                child: Text(student),
                              ),
                            )
                            .toList(),
                    onChanged: selectedClass == null
                        ? null
                        : (value) {
                            setState(() {
                              selectedStudent = value;
                            });
                          },
                    validator: (value) =>
                        value == null ? "Select a student" : null,
                  ),

                  const SizedBox(height: 16),

                  /// 🔹 Task Title
                  const Text(
                    "Task Title",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: taskTitleController,
                    decoration: _inputDecoration(Icons.task),
                    validator: (value) =>
                        value!.isEmpty ? "Enter task title" : null,
                  ),

                  const SizedBox(height: 16),

                  /// 🔹 Task Description
                  const Text(
                    "Task Description",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: taskDescController,
                    maxLines: 4,
                    decoration: _inputDecoration(Icons.description),
                    validator: (value) =>
                        value!.isEmpty ? "Enter description" : null,
                  ),

                  const SizedBox(height: 16),

                  /// 🔹 Due Date
                  const Text(
                    "Due Date",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () => pickDueDate(context),
                    child: InputDecorator(
                      decoration: _inputDecoration(Icons.calendar_today),
                      child: Text(
                        dueDate == null
                            ? "Select a date"
                            : "${dueDate!.day}/${dueDate!.month}/${dueDate!.year}",
                        style: TextStyle(
                          color: dueDate == null
                              ? baseTeal.withOpacity(0.7)
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// 🔹 Submit Button
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: baseTeal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Task assigned successfully"),
                              backgroundColor: baseTeal,
                            ),
                          );

                          taskTitleController.clear();
                          taskDescController.clear();

                          setState(() {
                            selectedClass = null;
                            selectedStudent = null;
                            dueDate = null;
                          });
                        }
                      },
                      child: const Text(
                        "Assign Task",
                        style: TextStyle(
                            fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 🔧 Common Input Decoration
  InputDecoration _inputDecoration(IconData icon) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      prefixIcon: Icon(icon, color: baseTeal),
    );
  }
}
