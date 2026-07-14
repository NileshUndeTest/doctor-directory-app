import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<Map<String, dynamic>> list = [
    {'icon': Icon(Icons.person), 'title': 'Name', 'sub': 'John Doe'},
    {'icon': Icon(Icons.today), 'title': 'Age', 'sub': '28 years'},
    {'icon': Icon(Icons.height), 'title': 'Height', 'sub': '175 cm'},
    {'icon': Icon(Icons.scale), 'title': 'Weight', 'sub': '70 Kg'},
    {
      'icon': Icon(Icons.phone_enabled),
      'title': 'Phone Number',
      'sub': '+91 9846149999',
    },
    {
      'icon': Icon(Icons.email),
      'title': 'Email Address',
      'sub': 'john.doe@gmail.com',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          // SizedBox(
          //   height: 150,
          //   child: Row(
          //     children: [
          //       Container(
          //         width: 150,
          //         decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           color: Colors.blue.shade900,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade900,
              foregroundColor: Colors.white,
              child: Icon(Icons.person),
            ),
            title: Text('John Doe', style: TextStyle(color: Colors.black)),
            titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
            subtitle: Text('Administrator'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: Offset.zero,
                    spreadRadius: 10,
                    color: Colors.grey.shade100,
                  ),
                ],
                color: Colors.white,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        // border: Border.all(),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: list[index]['icon'],
                    ),
                    title: Text(list[index]['title']),
                    subtitle: Text(list[index]['sub']),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: list.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
