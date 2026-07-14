import 'dart:ui';

import 'package:flutter/material.dart';

class Doctor {
  final String name;
  final String specialty;
  final String status; // 'Active', 'Offline', 'Busy'

  Doctor({
    required this.name,
    required this.specialty,
    required this.status,
  });
}

class DoctorCategory {
  final String name;
  final IconData icon;
  final List<Doctor> doctors;

  DoctorCategory({
    required this.name,
    required this.icon,
    required this.doctors,
  });
}


class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  int _selectedCategoryIndex = 0;

  final List<String> categories = ['All', 'Cardiology', 'Neurology', 'Orthopedics', 'Pediatrics'];

  // Mock Data mimicking the image
  final List<DoctorCategory> doctorCategories = [
    DoctorCategory(
      name: 'Cardiology',
      icon: Icons.favorite,
      doctors: [
        Doctor(name: 'Dr. Rahul Verma', specialty: 'MBBS, MD (Cardiology)', status: 'Active'),
        Doctor(name: 'Dr. Anjali Mehta', specialty: 'MBBS, DM (Cardiology)', status: 'Active'),
      ],
    ),
    DoctorCategory(
      name: 'Neurology',
      icon: Icons.psychology,
      doctors: [
        Doctor(name: 'Dr. Sanjay Kumar', specialty: 'MBBS, DM (Neurology)', status: 'Offline'),
        Doctor(name: 'Dr. Priya Sharma', specialty: 'MBBS, DNB (Neurology)', status: 'Busy'),
      ],
    ),
    DoctorCategory(
      name: 'Orthopedics',
      icon: Icons.dangerous_outlined,
      doctors: [
        Doctor(name: 'Dr. Vikram Singh', specialty: 'MBBS, MS (Orthopedics)', status: 'Active'),
        Doctor(name: 'Dr. Neha Kapoor', specialty: 'MBBS, MS (Orthopedics)', status: 'Busy'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF0A2558);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBlue,
        elevation: 0,
        
        title: const Text(
          'Doctors',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
         
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Search Bar Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search doctor by name...',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),

            
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 16),
                itemCount: categories.length + 1,
                itemBuilder: (context, index) {
                  if (index == categories.length) {
                    return const Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      child: Icon(Icons.more_horiz, color: Colors.grey),
                    );
                  }

                  final isSelected = _selectedCategoryIndex == index;
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(
                        categories[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: primaryBlue,
                      backgroundColor: Colors.white,
                      side: BorderSide(
                        color: isSelected ? Colors.transparent : Colors.grey.shade200,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedCategoryIndex = index;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

           
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: doctorCategories.length,
              itemBuilder: (context, catIndex) {
                final category = doctorCategories[catIndex];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category Header
                      Row(
                        children: [
                          Icon(category.icon, color: primaryBlue, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            category.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryBlue,
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.keyboard_arrow_down, color: primaryBlue),
                        ],
                      ),
                      const SizedBox(height: 8),
 
                      Column(
                        children: category.doctors.map((doctor) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.grey.shade100),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              leading: CircleAvatar(
                                radius: 24,
                                backgroundColor: primaryBlue,
                                child: Text(
                                  doctor.name.split(' ')[1][0], 
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              title: Text(
                                doctor.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black87,
                                ),
                              ),
                              subtitle: Text(
                                doctor.specialty,
                                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildStatusBadge(doctor.status),
                                  const SizedBox(width: 8),
                                  Icon(Icons.chevron_right, color: Colors.grey.shade400),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 80), 
          ],
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryBlue,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case 'Active':
        bgColor = const Color(0xFFE8F5E9);
        textColor = const Color(0xFF2E7D32);
        break;
      case 'Busy':
        bgColor = const Color(0xFFFFF3E0);
        textColor = const Color(0xFFE65100);
        break;
      case 'Offline':
      default:
        bgColor = const Color(0xFFEEEEEE);
        textColor = const Color(0xFF616161);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}