import 'dart:developer';

import 'package:doctor_directory_app/models/DoctorsAll.dart';
import 'package:doctor_directory_app/services/doctor_api.dart';
import 'package:doctor_directory_app/view/doctor_details.dart';
import 'package:flutter/material.dart';

class DoctorListing extends StatefulWidget {
  const DoctorListing({super.key});

  @override
  State<DoctorListing> createState() => _DoctorListingState();
}

class _DoctorListingState extends State<DoctorListing> {
  List<DoctorsAll> doctorsall = [];
  List<String> categories = [
    'All',
    'Cardiology',
    'Neurology',
    'Orthopedics',
    'Pediatrics',
  ];

  void loadDoctors() async {
    try {
      final data = await DoctorService().getAllDoctors();

      if (data.isNotEmpty) {
        print('doctor length:${doctorsall.length}');
        doctorsall = data;
        setState(() {});
      }
    } catch (e) {
      log('error loading user:$e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          try {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => AddDe,));
          } catch (e) {
            log('error at home nav:$e');
          }
        },
        backgroundColor: Colors.blue.shade900,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        title: Text('Doctors'),
        centerTitle: true,
        leading: Icon(Icons.menu),
        actions: [Icon(Icons.notifications)],
        actionsPadding: EdgeInsets.only(right: 40),
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search doctor by name...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 40,
              child: ListView.builder(
                padding: EdgeInsets.only(right: 10),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(child: Text(categories[index])),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),

            doctorsall.isEmpty
                ? SizedBox.shrink()
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: doctorsall.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Details(),
                              ),
                            );
                          },
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue.shade900,
                            foregroundColor: Colors.white,
                            child: Text('A'),
                          ),
                          title: Text(doctorsall[index].fullName.toString()),
                          subtitle: Text(
                            '${doctorsall[index].qualification}, (${doctorsall[index].department})',
                          ),
                          trailing: Row(mainAxisSize: MainAxisSize.min),
                        );
                        // return ExpansionTile(
                        //   leading: const Icon(Icons.monitor_heart),
                        //   title: const Text('Cardiology'),
                        //   children: List.generate(
                        //     2,
                        //     (i) => ListTile(
                        //       leading: CircleAvatar(
                        //         backgroundColor: Colors.blue.shade900,
                        //         foregroundColor: Colors.white,
                        //         child: Text('A'),
                        //       ),
                        //       title: Text('Dr Rahul Sharma'),
                        //       subtitle: Text('MBBS, MD (Cardiology)'),
                        //       trailing: Row(mainAxisSize: MainAxisSize.min),
                        //     ),
                        //   ),
                        // );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
