import 'package:doctor_directory_app/view/nav/doctor_listing.dart';
import 'package:doctor_directory_app/view/nav/profile.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> pages = [DoctorListing(), Profile()];
  List<String> heading = ['Doctors', 'Profile'];
  int selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.group_add),
            label: 'Doctors',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (value) {
          setState(() {
            selectedPage = value;
          });
        },
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue.shade900,
        currentIndex: selectedPage,
        // destinations: [
        //   NavigationDestination(icon: Icon(Icons.group_add), label: 'Doctors'),
        //   NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        // ],
      ),
    );
  }
}
