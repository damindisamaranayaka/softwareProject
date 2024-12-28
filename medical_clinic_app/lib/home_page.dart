import 'package:flutter/material.dart';
import 'login_page.dart';
import 'generalPatientInformation.dart'; // Updated import
import 'view_profile.dart';

class HomePage extends StatelessWidget {
  final String userName;

  const HomePage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: const Color.fromARGB(255, 255, 255, 255), // Background color fills the whole screen
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Ensures the Row fills the screen height
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
                        // Navigate to GeneralPatientInformation page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GeneralPatientInformation()), // Updated navigation
                        );
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 99, 181, 249)),
                      child: const Text('Edit Your Profile'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to the ViewProfile page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewProfile(userName: userName), // Pass userName to ViewProfile
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 99, 181, 249)),
                      child: const Text('View Your Profile'),
                    ),
                    const SizedBox(height: 20),
                    for (var text in [
                      'View Your Profile',
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
                        // Log out and navigate back to LoginPage
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
                    const SizedBox(height: 20),
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