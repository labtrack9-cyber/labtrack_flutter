import 'package:flutter/material.dart';
import 'package:labtrack/student/login.dart';

// ignore: must_be_immutable
class ComplaintPage extends StatefulWidget {
  const ComplaintPage({super.key});

  @override
  State<ComplaintPage> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  final TextEditingController complaint = TextEditingController();
  final _key = GlobalKey<FormState>();
  List<dynamic> reply = [];

  // 🎓 Theme colors
  static const Color primaryColor = Color(0xFF1E3A8A);
  static const Color backgroundColor = Color(0xFFF8FAFC);
  static const Color textColor = Color(0xFF111827);

  Future<void> postComplaint(BuildContext context) async {
    Map<String, dynamic> data = {'Complaint': complaint.text};

    try {
      final response = await dio.post(
        '$baseurl/complaint/$loginid',
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Complaint submitted successfully')),
        );
        complaint.clear();
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Submission failed')));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Something went wrong')));
    }
  }

  Future<void> getComplaint(BuildContext context) async {
    try {
      final response = await dio.get('$baseurl/complaint/$loginid');
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          reply = response.data;
        });
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text('Complaint submitted successfully')),
        // );
        // complaint.clear();
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Submission failed')));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Something went wrong')));
    }
  }

  @override
  void dispose() {
    complaint.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComplaint(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      // 🔹 App Bar
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text(
          'Complaint Page',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      // 🔹 Body
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Form(
                key: _key,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Submit Your Complaint",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      "We will review your complaint and respond accordingly.",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 24),

                    // 🔹 Complaint Text Field
                    TextFormField(
                      controller: complaint,
                      maxLines: 8,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your complaint';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Write your complaint',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: primaryColor),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 🔹 Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            postComplaint(context);
                          }
                        },
                        child: const Text(
                          "SUBMIT",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // 🔹 Complaint List (Sample UI)
                    ListView.builder(
  itemCount: reply.length,
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemBuilder: (context, index) {
    final item = reply[index];

    final complaintText =
        item['Complaint'] == null || item['Complaint'].toString().isEmpty
            ? 'No complaint text'
            : item['Complaint'].toString();

    final replyText =
        item['replay'] == null || item['replay'].toString().isEmpty
            ? 'No reply yet'
            : item['replay'].toString();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(
          complaintText,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            replyText,
            style: TextStyle(
              color: replyText == 'No reply yet'
                  ? Colors.grey
                  : Colors.green.shade700,
            ),
          ),
        ),
      ),
    );
  },
),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
