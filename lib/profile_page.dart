import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

static const Color navy =Color(0xFF16213E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ProfilePage.navy,
        elevation: 0,
        centerTitle:true,
        title: const Text("Profile",
        style: TextStyle(color: Colors.white),),
        
         
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            Row(
              children: [
                SizedBox(width: 20),
                const CircleAvatar(
                  radius: 45,
                  backgroundColor: ProfilePage.navy,
                  child: Icon(Icons.person, color: Colors.white, size: 50),
                ),
                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                    
                      const Text(
                        "John Doe",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Administrator",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(16),

              child: Card(
                elevation: 4,

                child: Padding(
                  padding: const EdgeInsets.all(16),

                  child: Column(
                    children: const [
                      ProfileTile(
                        icon: Icons.person_outline,
                        title: "Name",
                        value: "John Doe",
                      ),

                      Divider(color: Colors.grey, height: 2.0),

                      ProfileTile(
                        icon: Icons.calendar_today,
                        title: "Age",
                        value: "28 Years",
                      ),

                      Divider(color: Colors.grey, height: 2.0),

                      ProfileTile(
                        icon: Icons.height,
                        title: "Height",
                        value: "175 cm",
                      ),

                      Divider(color: Colors.grey, height: 2.0),

                      ProfileTile(
                        icon: Icons.line_weight,
                        title: "Weight",
                        value: "70 kg",
                      ),

                      Divider(color: Colors.grey, height: 2.0),

                      ProfileTile(
                        icon: Icons.phone,
                        title: "Phone",
                        value: "+91 9876543210",
                      ),

                      Divider(color: Colors.grey, height: 2.0),

                      ProfileTile(
                        icon: Icons.email_outlined,
                        title: "Email",
                        value: "john@example.com",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: ProfilePage.navy),

      title: Text(title),

      subtitle: Text(value),
    );
  }
}
