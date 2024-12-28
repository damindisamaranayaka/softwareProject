import 'package:flutter/material.dart';

class ViewProfile extends StatelessWidget {
  final String userName; // Pass the userName from HomePage

  const ViewProfile({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Profile'),
        backgroundColor: const Color.fromARGB(255, 99, 181, 249),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
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
            const Text(
              'Full Name:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(userName), // Show user's name
            const SizedBox(height: 20),
            const Text(
              'Gender:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('Male/Female'),
            const SizedBox(height: 20),
            const Text(
              'Phone Number:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('+1234567890'),
            const SizedBox(height: 20),
            const Text(
              'Email:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('example@mail.com'),
            const SizedBox(height: 20),
            const Text(
              'Address:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('123 Street, City, Country'),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the home page
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
    );
  }
}