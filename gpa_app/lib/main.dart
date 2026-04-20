import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

  // INPUT
  TextEditingController marksController = TextEditingController();

  final player = AudioPlayer();

  void playSound() {
  player.play(AssetSource('audio/photoclick.mp3'));
}

  // OUTPUT
  String grade = "";
  double gradePoint = 0.0;
  String remarks = "";

  @override
  void dispose() {
    marksController.dispose();
    super.dispose();
  }

  // LOGIC
  void calculateGPA() {
    double marks = double.tryParse(marksController.text) ?? 0;

    setState(() {
      if (marks > 100 || marks < 0) {
        grade = "-";
        gradePoint = 0.0;
        remarks = "Invalid Input";
      } else if (marks >= 90) {
        grade = "A+";
        gradePoint = 4.00;
        remarks = "Excellent";
      } else if (marks >= 80) {
        grade = "A";
        gradePoint = 4.00;
        remarks = "Excellent";
      } else if (marks >= 75) {
        grade = "A-";
        gradePoint = 3.67;
        remarks = "Good";
      } else if (marks >= 70) {
        grade = "B+";
        gradePoint = 3.33;
        remarks = "Good";
      } else if (marks >= 65) {
        grade = "B";
        gradePoint = 3.00;
        remarks = "Good";
      } else if (marks >= 60) {
        grade = "B-";
        gradePoint = 2.67;
        remarks = "Satisfactory";
      } else if (marks >= 55) {
        grade = "C+";
        gradePoint = 2.33;
        remarks = "Satisfactory";
      } else if (marks >= 50) {
        grade = "C";
        gradePoint = 2.00;
        remarks = "Pass";
      } else if (marks >= 45) {
        grade = "C-";
        gradePoint = 1.67;
        remarks = "Fail";
      } else if (marks >= 40) {
        grade = "D+";
        gradePoint = 1.33;
        remarks = "Fail";
      } else if (marks >= 35) {
        grade = "D";
        gradePoint = 1.00;
        remarks = "Fail";
      } else {
        grade = "F";
        gradePoint = 0.00;
        remarks = "Fail";
      }
    });
  }

  // CLEAR
  void clearData() {
    setState(() {
      marksController.clear();
      grade = "";
      gradePoint = 0.0;
      remarks = "";
    });
  }

  // UI
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

            // 🖼️ IMAGE
            Image.asset(
              'assets/images/logo_uum.png',
              height: 120,
            ),

            const SizedBox(height: 20),

            const Text(
              "Enter Student Marks",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // INPUT
            TextField(
              controller: marksController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter marks (0 - 100)",
              ),
            ),

            const SizedBox(height: 20),

            // BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    calculateGPA();
                    playSound();
                  },
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

            // OUTPUT
            Text(
              "Grade: $grade",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            Text(
              "Grade Point: ${gradePoint.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 20),
            ),

            Text(
              "Remarks: $remarks",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}