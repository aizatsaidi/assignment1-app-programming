import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'GPA Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // INPUT CONTROLLER
  TextEditingController marksController = TextEditingController();

  // OUTPUT VARIABLES
  double gpa = 0.0;
  String status = "";

  @override
  void dispose() {
    marksController.dispose();
    super.dispose();
  }

  void calculateGPA() {
    double marks = double.tryParse(marksController.text) ?? 0;

    setState(() {
      if (marks >= 80) {
        gpa = 4.0;
        status = "Excellent";
      } else if (marks >= 65) {
        gpa = 3.0;
        status = "Good";
      } else if (marks >= 50) {
        gpa = 2.0;
        status = "Pass";
      } else {
        gpa = 1.0;
        status = "Fail";
      }
    });
  }

  void clearData() {
    setState(() {
      marksController.clear();
      gpa = 0.0;
      status = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            const Text(
              "Enter Student Marks",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: marksController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter marks (0 - 100)",
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: calculateGPA,
                  child: const Text("Calculate"),
                ),
                ElevatedButton(
                  onPressed: clearData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text("Clear"),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Text(
              "GPA: $gpa",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            Text(
              "Status: $status",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}