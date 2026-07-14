import 'dart:convert';
import 'package:doctor_directory_app/model/WorkExperienceItem.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://6a5492808547b9f7111c7104.mockapi.io';
  static const String endpoint = '/api/hackathon/doctor';

  static bool _useLocalFallback = false;

  static final List<Doctor> _localDb = [
    Doctor(
      id: "1",
      fullName: "Dr. Emily Carter",
      avatar: "EC",
      qualification: "MD, Cardiology",
      department: "Cardiology",
      age: "45",
      yearsOfExperience: "18 Years",
      status: "Active",
      about:
          "Experienced cardiologist specializing in preventive cardiology and heart failure management.",
      workExperience: [
        {
          "startYear": "2006",
          "endYear": "2014",
          "hospitalName": "Boston Heart Center",
          "role": "Cardiologist",
        },
        {
          "startYear": "2014",
          "endYear": "Present",
          "hospitalName": "Massachusetts General Hospital",
          "role": "Senior Cardiologist",
        },
      ],
    ),
    Doctor(
      id: "2",
      fullName: "Dr. Michael Johnson",
      avatar: "MJ",
      qualification: "MBBS, MS Orthopedics",
      department: "Orthopedics",
      age: "50",
      yearsOfExperience: "24 Years",
      status: "Active",
      about: "Expert in joint replacement and sports injury treatment.",
      workExperience: [
        {
          "startYear": "2001",
          "endYear": "2012",
          "hospitalName": "Mercy Hospital",
          "role": "Orthopedic Surgeon",
        },
        {
          "startYear": "2012",
          "endYear": "Present",
          "hospitalName": "Johns Hopkins Hospital",
          "role": "Senior Orthopedic Surgeon",
        },
      ],
    ),
    Doctor(
      id: "3",
      fullName: "Dr. Sophia Lee",
      avatar: "SL",
      qualification: "MD Pediatrics",
      department: "Pediatrics",
      age: "39",
      yearsOfExperience: "13 Years",
      status: "Active",
      about: "Dedicated pediatrician focused on preventive child healthcare.",
      workExperience: [
        {
          "startYear": "2012",
          "endYear": "2018",
          "hospitalName": "Sunrise Medical Center",
          "role": "Pediatrician",
        },
        {
          "startYear": "2018",
          "endYear": "Present",
          "hospitalName": "Seattle Children's Hospital",
          "role": "Consultant Pediatrician",
        },
      ],
    ),
    Doctor(
      id: "4",
      fullName: "Dr. David Wilson",
      avatar: "DW",
      qualification: "MD Neurology",
      department: "Neurology",
      age: "47",
      yearsOfExperience: "20 Years",
      status: "Offline",
      about: "Specializes in stroke management and epilepsy treatment.",
      workExperience: [
        {
          "startYear": "2005",
          "endYear": "2015",
          "hospitalName": "City Medical Center",
          "role": "Neurologist",
        },
        {
          "startYear": "2015",
          "endYear": "Present",
          "hospitalName": "Cleveland Clinic",
          "role": "Senior Neurologist",
        },
      ],
    ),
    Doctor(
      id: "5",
      fullName: "Dr. Olivia Martinez",
      avatar: "OM",
      qualification: "MBBS, MD Dermatology",
      department: "Dermatology",
      age: "41",
      yearsOfExperience: "15 Years",
      status: "Active",
      about: "Expert in cosmetic dermatology and skin cancer screening.",
      workExperience: [
        {
          "startYear": "2011",
          "endYear": "2017",
          "hospitalName": "Skin Care Clinic",
          "role": "Dermatologist",
        },
        {
          "startYear": "2017",
          "endYear": "Present",
          "hospitalName": "Stanford Health",
          "role": "Senior Dermatologist",
        },
      ],
    ),
    Doctor(
      id: "21",
      fullName: "Dr. Rahul Verma",
      avatar: "RV",
      qualification: "MBBS, MD (Cardiology)",
      department: "Cardiology",
      age: "45",
      yearsOfExperience: "15 Years",
      status: "Active",
      about:
          "Experienced cardiologist specializing in interventional cardiology and cardiac diagnostics.",
      workExperience: "Senior Cardiologist at Apollo Hospital",
    ),
  ];

  Future<List<Doctor>> getDoctors() async {
    if (_useLocalFallback) {
      return List.from(_localDb);
    }

    try {
      final response = await http.get(Uri.parse('$baseUrl$endpoint'));
      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body);
        return body.map((item) => Doctor.fromJson(item)).toList();
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(
        'ApiService: Failing back to local database. Network/CORS Exception: $e',
      );
      _useLocalFallback = true;
      return List.from(_localDb);
    }
  }

  Future<Doctor> getDoctorById(String id) async {
    if (_useLocalFallback) {
      return _localDb.firstWhere((doc) => doc.id == id);
    }

    try {
      final response = await http.get(Uri.parse('$baseUrl$endpoint/$id'));
      if (response.statusCode == 200) {
        return Doctor.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(
        'ApiService: Failing back to local lookup. Network/CORS Exception: $e',
      );
      return _localDb.firstWhere(
        (doc) => doc.id == id,
        orElse: () => throw Exception('Doctor with ID $id not found: $e'),
      );
    }
  }

  Future<Doctor> createDoctor(Doctor doctor) async {
    if (_useLocalFallback) {
      final newId = (DateTime.now().millisecondsSinceEpoch % 100000).toString();
      final newDoc = Doctor(
        id: newId,
        fullName: doctor.fullName,
        avatar: doctor.avatar,
        qualification: doctor.qualification,
        department: doctor.department,
        age: doctor.age,
        yearsOfExperience: doctor.yearsOfExperience,
        status: doctor.status,
        about: doctor.about,
        workExperience: doctor.workExperience,
      );
      _localDb.add(newDoc);
      return newDoc;
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(doctor.toJson()),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return Doctor.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(
        'ApiService: Failing back to local create. Network/CORS Exception: $e',
      );
      _useLocalFallback = true;
      final newId = (DateTime.now().millisecondsSinceEpoch % 100000).toString();
      final newDoc = Doctor(
        id: newId,
        fullName: doctor.fullName,
        avatar: doctor.avatar,
        qualification: doctor.qualification,
        department: doctor.department,
        age: doctor.age,
        yearsOfExperience: doctor.yearsOfExperience,
        status: doctor.status,
        about: doctor.about,
        workExperience: doctor.workExperience,
      );
      _localDb.add(newDoc);
      return newDoc;
    }
  }

  Future<bool> deleteDoctor(String id) async {
    if (_useLocalFallback) {
      _localDb.removeWhere((doc) => doc.id == id);
      return true;
    }

    try {
      final response = await http.delete(Uri.parse('$baseUrl$endpoint/$id'));
      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(
        'ApiService: Failing back to local delete. Network/CORS Exception: $e',
      );
      _localDb.removeWhere((doc) => doc.id == id);
      return true;
    }
  }
}
