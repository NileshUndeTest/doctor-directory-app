import 'package:doctor_directory_app/model/WorkExperienceItem.dart';
import 'package:doctor_directory_app/service/doctor_service.dart';
import 'package:flutter/material.dart';

class DoctorProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Doctor> _doctors = [];
  bool _isLoading = false;
  String? _error;

  List<Doctor> get doctors => _doctors;
  bool get isLoading => _isLoading;
  String? get error => _error;

  final Map<String, Doctor> _doctorDetails = {};
  final Map<String, bool> _loadingDetails = {};
  final Map<String, String?> _errorDetails = {};

  Doctor? getDoctorDetail(String id) => _doctorDetails[id];
  bool isDetailLoading(String id) => _loadingDetails[id] ?? false;
  String? getDetailError(String id) => _errorDetails[id];

  // Fetch all doctors
  Future<void> fetchDoctors() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _doctors = await _apiService.getDoctors();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch single doctor details
  Future<void> fetchDoctorDetails(String id) async {
    _loadingDetails[id] = true;
    _errorDetails[id] = null;
    notifyListeners();

    try {
      final doc = await _apiService.getDoctorById(id);
      _doctorDetails[id] = doc;

      // Update in the main list too if it exists
      final index = _doctors.indexWhere((element) => element.id == id);
      if (index != -1) {
        _doctors[index] = doc;
      }
    } catch (e) {
      _errorDetails[id] = e.toString();
    } finally {
      _loadingDetails[id] = false;
      notifyListeners();
    }
  }

  // Add a new doctor
  Future<bool> addDoctor(Doctor doctor) async {
    try {
      final newDoc = await _apiService.createDoctor(doctor);
      _doctors.add(newDoc);
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error adding doctor: $e');
      rethrow;
    }
  }

  // Delete a doctor
  Future<bool> removeDoctor(String id) async {
    try {
      final success = await _apiService.deleteDoctor(id);
      if (success) {
        _doctors.removeWhere((doc) => doc.id == id);
        _doctorDetails.remove(id);
        notifyListeners();
      }
      return success;
    } catch (e) {
      debugPrint('Error deleting doctor: $e');
      rethrow;
    }
  }
}
