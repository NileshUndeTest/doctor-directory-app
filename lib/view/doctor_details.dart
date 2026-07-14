import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor:Color.fromARGB(255, 6, 46, 208),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Doctor Details', style: TextStyle(color: Colors.white)),
        
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 6, 46, 208),
                ),
              ),
              Column(
                children: [
                  Text(
                    'Doctor Name',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    'MBBS, MD',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Specialization',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(16),
            child: Text(
              'Personal Information',
              style: TextStyle(fontSize: 16),
            ),
          ),
          
        ],
      ),
    );
  }
}