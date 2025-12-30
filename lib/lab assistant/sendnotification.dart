import 'package:flutter/material.dart';

class SendNotificationPage extends StatefulWidget {
  const SendNotificationPage({super.key});

  @override
  State<SendNotificationPage> createState() => _SendNotificationPageState();
}

class _SendNotificationPageState extends State<SendNotificationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  String? selectedClass;

  final List<String> classes = [
    "Class 1",
    "Class 2",
    "Class 3",
    "Class 4",
  ];

  // 🎨 Teal theme
  static const Color baseTeal = Color(0xFF008080);
  static final Color lightTeal = baseTeal.withOpacity(0.1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightTeal,
      appBar: AppBar(
        backgroundColor: baseTeal,
        centerTitle: true,
        title: const Text(
          "Send Notification",
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 🔹 Select Class Dropdown
                  Text(
                    "Select Class",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: baseTeal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selectedClass,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.class_),
                    ),
                    items: classes
                        .map((cls) => DropdownMenuItem(
                              value: cls,
                              child: Text(cls),
                            ))
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

                  // 🔹 Notification Title
                  Text(
                    "Title",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: baseTeal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.title),
                      hintText: "Enter notification title",
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Enter a title" : null,
                  ),
                  const SizedBox(height: 16),

                  // 🔹 Notification Message
                  Text(
                    "Message",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: baseTeal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: messageController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.message),
                      hintText: "Enter notification message",
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Enter a message" : null,
                  ),
                  const SizedBox(height: 24),

                  // 🔹 Send Button
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
                            SnackBar(
                              content: Text(
                                  "Notification sent to $selectedClass successfully!"),
                            ),
                          );
                          titleController.clear();
                          messageController.clear();
                          setState(() {
                            selectedClass = null;
                          });
                        }
                      },
                      child: const Text(
                        "Send Notification",
                        style: TextStyle(fontSize: 18,color: Colors.white),
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
