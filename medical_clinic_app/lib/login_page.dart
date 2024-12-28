import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'registration_page.dart'; 
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  // New variable for password visibility
  bool _isPasswordVisible = false;

  // Login method
  Future<void> _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    const String url = 'http://localhost:3000/api/login'; // Replace <YOUR_IP_ADDRESS> with your actual IP address

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
        Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => HomePage(userName: username)),
      );
        final token = responseBody['token'];
        if (kDebugMode) {
          print('Login successful! Token: $token');
        }
        // Navigate to another screen if needed
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
                  MaterialPageRoute(builder: (context) => const RegistrationPage()),
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