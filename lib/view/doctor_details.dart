import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  void _showRemoveDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red.shade200, width: 1.5),
                ),
                child: Icon(Icons.delete_outline, color: Colors.red, size: 30),
              ),
              SizedBox(height: 16),
              Text(
                'Remove Doctor',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                'Are you sure you want to delete this doctor? This action cannot be undone.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        Navigator.pop(context); 
                      },
                      child: Text('Cancel', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  SizedBox(width: 12),
                  
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        Navigator.pop(context); 
                        Navigator.pop(context); 
                      },
                      child: Text('Remove', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 6, 46, 208),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Doctor Details', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 6, 46, 208),
                  ),
                  child: Center(
                    child: Text(
                      'R',
                      style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [
                    Text(
                      'Dr. Rahul Verma',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'MBBS, MD (Cardiology)',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    Text(
                      'Cardiology',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(height: 6),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.shade700,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Active',
                        style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ],
            ),

            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), 
              child: Container(
                padding: EdgeInsets.all(16.0), 
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200, width: 1.0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [
                    Text(
                      'Personal Information',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16), 
                    Row(
                      children: [
                        Icon(Icons.person_outline, color: Colors.grey.shade600),
                        SizedBox(width: 12), 
                        Text('Age', style: TextStyle(fontSize: 15, color: Colors.black87)),
                        Spacer(),
                        Text('45 Years', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    SizedBox(height: 16), 
                    Row(
                      children: [
                        Icon(Icons.business_center_outlined, color: Colors.grey.shade600),
                        SizedBox(width: 12),
                        Text('Experience', style: TextStyle(fontSize: 15, color: Colors.black87)),
                        Spacer(),
                        Text('15 Years', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    SizedBox(height: 16), 
                    Row(
                      children: [
                        Icon(Icons.local_hospital_outlined, color: Colors.grey.shade600),
                        SizedBox(width: 12),
                        Text('Department', style: TextStyle(fontSize: 15, color: Colors.black87)),
                        Spacer(),
                        Text('Cardiology', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), 
              child: Container(
                padding: EdgeInsets.all(16.0), 
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200, width: 1.0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [
                    Text(
                      'About Me',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12), 
                    Text(
                      'Experienced Cardiologist with a demonstrated history of working in the healthcare industry. Skilled in Interventional Cardiology, Cardiac Diagnostics and Patient Care.',
                      style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.4),
                    ),
                  ],
                ),
              ),
            ),
            
           
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), 
              child: Container(
                padding: EdgeInsets.all(16.0), 
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200, width: 1.0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Work Experience", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    
                    // Timeline Item 1
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(radius: 6, backgroundColor: Color.fromARGB(255, 6, 46, 208)),
                            Container(width: 2, height: 50, color: Colors.grey.shade300),
                          ],
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("2024 - Present", style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 6, 46, 208), fontWeight: FontWeight.w600)),
                            Text("Senior Cardiologist", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                            Text("Apollo Hospital", style: TextStyle(fontSize: 13, color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(radius: 6, backgroundColor: Color.fromARGB(255, 6, 46, 208)),
                            Container(width: 2, height: 50, color: Colors.grey.shade300),
                          ],
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("2020 - 2024", style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 6, 46, 208), fontWeight: FontWeight.w600)),
                            Text("Consultant Cardiologist", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                            Text("Fortis Hospital", style: TextStyle(fontSize: 13, color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(radius: 6, backgroundColor: Color.fromARGB(255, 6, 46, 208)),
                          ],
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("2016 - 2020", style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 6, 46, 208), fontWeight: FontWeight.w600)),
                            Text("Resident Doctor", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                            Text("City Medical Center", style: TextStyle(fontSize: 13, color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            
            Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _showRemoveDialog, // triggers the functional alert popup
                  icon: Icon(Icons.delete_outline, color: Colors.red),
                  label: Text(
                    'Remove Doctor',
                    style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w600),
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