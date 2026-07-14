import 'package:doctor_directory_app/provider/doctor_provider.dart';
import 'package:doctor_directory_app/screen/root_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => DoctorProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor Directory',
      debugShowCheckedModeBanner: false,
      home: const MainNavigationView(),
    );
  }
}
