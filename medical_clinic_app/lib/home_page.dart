import 'package:flutter/material.dart';
import 'login_page.dart';
import 'generalPatientInformation.dart'; // Updated import
import 'view_profile.dart';

class HomePage extends StatelessWidget {
  final String userName;
  final String patientId;

  const HomePage({required this.userName, required this.patientId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome $userName'),
        backgroundColor: const Color.fromARGB(255, 99, 181, 249),
      ),
      body: Container(
        color: const Color.fromARGB(255, 255, 255, 255), // Background color
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Ensures Row fills screen height
          children: [
            Container(
              color: const Color.fromARGB(187, 10, 216, 213),
              width: MediaQuery.of(context).size.width * 0.5,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi !\n$userName',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GeneralPatientInformation(patientId: patientId),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 99, 181, 249)),
                      child: const Text('Edit Your Profile'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewProfile(userId: patientId), // Pass userName to ViewProfile
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 99, 181, 249)),
                      child: const Text('View Your Profile'),
                    ),
                    const SizedBox(height: 20),
                    for (var text in [
                      
                      'Make an Appointment',
                      'View Test Results',
                      'View Prescription',
                      'View the Bill',
                      'Health Educations'
                    ])
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 105, 181, 247),
                          ),
                          child: Text(text),
                        ),
                      ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text('Log Out'),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: const Color.fromARGB(255, 155, 239, 237),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            'Care',
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'Plus',
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 105, 181, 247)),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Image.network(
                      'https://s3-media0.fl.yelpcdn.com/bphoto/kROaBMMNs2u1t9RHYMbv9g/1000s.jpg',
                      width: 100,
                      height: 100,
                    ),
                   /* const SizedBox(height: 20),
                    Text(
                      'Patient ID: $patientId',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,  
                    ),  */
                    const SizedBox(height: 10),
                    const Text(
                      'The Best Medical Clinic for You!',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
