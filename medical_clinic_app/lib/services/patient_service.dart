// lib/services/patient_service.dart

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:medical_clinic_app/services/token_storage.dart';

class PatientService {
  // Save patient general information
  Future<bool> savePatientInfo(Map<String, dynamic> patientData) async {
    final token = await getToken(); // Retrieve the JWT token
    if (token == null) {
      print('User is not logged in. Please log in to continue.');
      return false;
    }

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/patient/${patientData["id"]}/general-info'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(patientData),
      );

      if (response.statusCode == 200) {
        print('Patient information saved successfully!');
        return true;
      } else {
        print('Failed to save patient info. Error: ${response.body}');
        return false;
      }
    } catch (e) {
      print('An error occurred while saving patient info: $e');
      return false;
    }
  }
}
