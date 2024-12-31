import 'package:flutter/material.dart';
import 'package:medical_clinic_app/services/patient_service.dart';

class ViewProfile extends StatefulWidget {
  final String userId; // Pass the userId from Login or HomePage

  const ViewProfile({super.key, required this.userId});

  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  Map<String, dynamic>? userProfile;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    final service = PatientService();
    final profile = await service.fetchPatientProfile(widget.userId); // Fetch user profile data
    setState(() {
      userProfile = profile;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Profile'),
        backgroundColor: const Color.fromARGB(255, 99, 181, 249),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userProfile != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Color.fromARGB(255, 99, 181, 249),
                            child: Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Display basic profile information
                        _buildProfileSection('Basic Information', [
                          _buildProfileRow('Full Name:', userProfile?['fullname']),
                          _buildProfileRow('Gender:', userProfile?['gender']),
                          _buildProfileRow('Phone Number:', userProfile?['phone']),
                          _buildProfileRow('Email:', userProfile?['email']),
                          _buildProfileRow('Address:', userProfile?['address']),
                        ]),
                        const SizedBox(height: 20),
                        // Display generalInfo data
                        _buildProfileSection('General Information', [
                          _buildProfileRow('Gender:', userProfile?['generalInfo']?['gender']),
                          _buildProfileRow('Birth Date:', userProfile?['generalInfo']?['birthDate']),
                          _buildProfileRow('Height:', '${userProfile?['generalInfo']?['height']} cm'),
                          _buildProfileRow('Weight:', '${userProfile?['generalInfo']?['weight']} kg'),
                          _buildProfileRow('Reason for Visit:', userProfile?['generalInfo']?['reasonForVisit']),
                        ]),
                        const SizedBox(height: 20),
                        // Display medicalHistory data
                        _buildProfileSection('Medical History', [
                          _buildProfileRow('Drug Allergies:', userProfile?['medicalHistory']?['drugAllergies']),
                          _buildProfileRow('Other Illnesses:', userProfile?['medicalHistory']?['otherIllnesses']),
                          _buildProfileRow('Current Medications:', userProfile?['medicalHistory']?['currentMedications']),
                          _buildProfileRow(
                            'Conditions:',
                            (userProfile?['medicalHistory']?['conditions'] as List<dynamic>?)
                                ?.join(', ') ??
                                'N/A',
                          ),
                        ]),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 99, 181, 249),
                            minimumSize: const Size.fromHeight(50),
                          ),
                          child: const Text('Back to Home'),
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: Text('Failed to load profile. Please try again.'),
                ),
    );
  }

  Widget _buildProfileRow(String label, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(value ?? 'N/A'),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildProfileSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Divider(thickness: 1),
        ...children,
      ],
    );
  }
}
