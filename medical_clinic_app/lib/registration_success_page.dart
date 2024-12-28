import 'package:flutter/material.dart';
import 'login_page.dart';

class RegistrationSuccessPage extends StatelessWidget {
  const RegistrationSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 155, 239, 237),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Care',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Plus',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[600], // Blue color for "Plus"
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Image.network(
              'https://s3-media0.fl.yelpcdn.com/bphoto/kROaBMMNs2u1t9RHYMbv9g/1000s.jpg',
              width: 80,
              height: 80,
            ),
            const SizedBox(height: 30),
            const Text(
              'Congratulations!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'You have successfully registered.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Navigate to the LoginPage when "Done" is clicked
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false, 
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, 
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Done',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
