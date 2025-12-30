import 'package:flutter/material.dart';

class AssignTaskToClassPage extends StatefulWidget {
  const AssignTaskToClassPage({super.key});

  @override
  State<AssignTaskToClassPage> createState() => _AssignTaskToClassPageState();
}

class _AssignTaskToClassPageState extends State<AssignTaskToClassPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskDescController = TextEditingController();

  DateTime? dueDate;
  String? selectedClass;

  // Sample class list
  final List<String> classes = [
    "Class 8 - A",
    "Class 8 - B",
    "Class 9 - A",
    "Class 10 - Science",
  ];

  // 🎨 Theme colors (same as your original screen)
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
      setState(() {
        dueDate = date;
      });
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
          "Assign Task to Class",
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
                  /// Assign to Class
                  const Text(
                    "Assign to Class",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selectedClass,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.groups, color: baseTeal),
                    ),
                    items: classes
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
                    validator: (value) =>
                        value == null ? "Select a class" : null,
                  ),

                  const SizedBox(height: 16),

                  /// Task Title
                  const Text(
                    "Task Title",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: taskTitleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.task, color: baseTeal),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Enter task title" : null,
                  ),

                  const SizedBox(height: 16),

                  /// Task Description
                  const Text(
                    "Task Description",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: taskDescController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon:
                          const Icon(Icons.description, color: baseTeal),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Enter description" : null,
                  ),

                  const SizedBox(height: 16),

                  /// Due Date
                  const Text(
                    "Due Date",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () => pickDueDate(context),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon:
                            const Icon(Icons.calendar_today, color: baseTeal),
                      ),
                      child: Text(
                        dueDate != null
                            ? "${dueDate!.day}/${dueDate!.month}/${dueDate!.year}"
                            : "Select a date",
                        style: TextStyle(
                          color: dueDate != null
                              ? Colors.black
                              : baseTeal.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// Assign Button
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
                                  Text("Task assigned to class successfully"),
                              backgroundColor: baseTeal,
                            ),
                          );

                          taskTitleController.clear();
                          taskDescController.clear();
                          setState(() {
                            selectedClass = null;
                            dueDate = null;
                          });
                        }
                      },
                      child: const Text(
                        "Assign Task",
                        style:
                            TextStyle(fontSize: 18, color: Colors.white),
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
}
