import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddDoctor(),
    );
  }
}

class AddDoctor extends StatefulWidget {
  const AddDoctor({super.key});

  @override
  State<AddDoctor> createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  String department = "-- Select Department --";
  String status = "-Select Status-";

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController aboutMeController = TextEditingController();
  int aboutMeCount = 0;

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    qualificationController.dispose();
    experienceController.dispose();
    aboutMeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 8, 66, 168),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          "Add Doctor",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Full Name"),
            const SizedBox(height: 5),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: "Enter Full Name",
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            const Text("Age"),
            const SizedBox(height: 5),
            TextFormField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Enter the age",
                prefixIcon: Icon(Icons.today),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            const Text("Qualification"),
            const SizedBox(height: 5),
            TextFormField(
              controller: qualificationController,
              decoration: const InputDecoration(
                hintText: "Enter Qualification",
                prefixIcon: Icon(Icons.school),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "Department",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            DropdownButtonFormField<String>(
              value: department,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items:
                  const [
                    "-- Select Department --",
                    "Cardiology",
                    "Orthopedic",
                    "Neurology",
                    "Pediatrics",
                    "Dermatology",
                  ].map((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  department = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Years of Experience"),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: experienceController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: "Enter the Years",
                          prefixIcon: Icon(Icons.currency_bitcoin),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Status",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      DropdownButtonFormField<String>(
                        value: status,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        items:
                            const [
                              "-Select Status-",
                              "Active",
                              "Busy",
                              "Offline",
                            ].map((item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            status = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              "About Me",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),

            TextFormField(
              controller: aboutMeController,
              maxLines: 6,
              maxLength: 500,
              onChanged: (value) {
                setState(() {
                  aboutMeCount = value.length;
                });
              },
              decoration: InputDecoration(
                hintText: "Write about the doctor...",
                border: const OutlineInputBorder(),
                alignLabelWithHint: true,
                counterText: "$aboutMeCount/500",
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 8, 66, 168),
                ),
                onPressed: () {
                  print("Name: ${nameController.text}");
                  print("Age: ${ageController.text}");
                  print("Qualification: ${qualificationController.text}");
                  print("Department: $department");
                  print("Experience: ${experienceController.text}");
                  print("Status: $status");
                  print("About Me:${aboutMeController.text}");
                },
                child: const Text(
                  "Create Doctor",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
