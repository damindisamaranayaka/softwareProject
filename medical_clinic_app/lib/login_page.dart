import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'registration_page.dart';
import 'home_page.dart';
import 'package:medical_clinic_app/services/token_storage.dart'; // Adjust the path as needed

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  // New variable for password visibility
  bool _isPasswordVisible = false;

  // Handle login success by saving token and patientId and navigating
  void handleLoginSuccess(String token, String patientId) async {
    // Save the token
    await saveToken(token);

    // Save the patientId if needed for local use
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('patientId', patientId);

    // Navigate to the home page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          userName: _usernameController.text,
          patientId: patientId,
        ),
      ),
    );
  }

  // Login method
  Future<void> _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    const String url = 'http://localhost:3000/api/login'; // Replace with your actual endpoint

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Successful login
        final responseBody = json.decode(response.body);
        final token = responseBody['token']; // API token key
        final patientId = responseBody['patientId']; // Extract patientId

        if (kDebugMode) {
          print('Login successful! Token: $token, PatientId: $patientId');
        }

        // Handle login success
        handleLoginSuccess(token, patientId);
      } else {
        setState(() {
          _errorMessage = 'Invalid username or password';
          if (kDebugMode) {
            print('Server response: ${response.body}');
          }
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 155, 239, 237),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.network(
                'https://s3-media0.fl.yelpcdn.com/bphoto/kROaBMMNs2u1t9RHYMbv9g/1000s.jpg',
                width: 100,
                height: 100,
              ),
            ),
            const Text(
              'Welcome to Care Plus',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                errorText: _errorMessage,
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: _errorMessage,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    // Toggle password visibility
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              obscureText: !_isPasswordVisible,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            const SizedBox(height: 10),
            const Text(
              "Don't have an account? Register",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegistrationPage(),
                  ),
                );
              },
              child: const Text('Register'),
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
