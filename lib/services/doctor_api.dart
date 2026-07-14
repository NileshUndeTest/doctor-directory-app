import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../models/DoctorsAll.dart';



class DoctorService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "YOUR_BASE_URL",
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        "Content-Type": "application/json",
      },
    ),
  )..interceptors.add(
    PrettyDioLogger(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ),
  );

  /// GET ALL DOCTORS
  Future<List<DoctorsAll>> getAllDoctors() async {
    try {
      final response = await dio.get("/api/hackathon/doctor");

      return (response.data as List)
          .map((e) => DoctorsAll.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? e.message);
    }
  }

  /// GET DOCTOR BY ID
  Future<DoctorsAll> getDoctorById(String id) async {
    try {
      final response = await dio.get("/api/hackathon/doctor/$id");

      return DoctorsAll.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? e.message);
    }
  }

  /// CREATE DOCTOR
  Future<DoctorsAll> createDoctor(DoctorsAll doctor) async {
    try {
      final response = await dio.post(
        "/api/hackathon/doctor",
        data: doctor.toJson(),
      );

      return DoctorsAll.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? e.message);
    }
  }

  /// DELETE DOCTOR
  Future<void> deleteDoctor(String id) async {
    try {
      await dio.delete("/api/hackathon/doctor/$id");
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? e.message);
    }
  }
}