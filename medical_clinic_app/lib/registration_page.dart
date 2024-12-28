import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'registration_success_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nicController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String? _errorMessage;
  String? _gender;

  final List<String> _genders = ['Male', 'Female'];

  // Registration method
  Future<void> _register() async {
    final String fullname = _fullnameController.text;
    final String gender = _gender ?? '';
    final String phone = _phoneController.text;
    final String email = _emailController.text;
    final String nic = _nicController.text;
    final String address = _addressController.text;
    final String username = _usernameController.text;
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      setState(() {
        _errorMessage = 'Passwords do not match';
      });
      return;
    }

    const String url = 'http://localhost:3000/api/register';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'fullname': fullname,
          'gender': gender,
          'phone': phone,
          'email': email,
          'nic': nic,
          'address': address,
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        // Navigate to RegistrationSuccessPage after successful registration
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const RegistrationSuccessPage()),
        );
      } else {
        setState(() {
          _errorMessage = 'Registration failed: ${response.body}';
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
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
              const SizedBox(height: 20),
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
                controller: _fullnameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              DropdownButtonFormField<String>(
                value: _gender,
                decoration: const InputDecoration(labelText: 'Gender'),
                items: _genders.map((String gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _gender = value;
                  });
                },
              ),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _nicController,
                decoration: const InputDecoration(labelText: 'NIC Number'),
              ),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
              ),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              TextField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
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
      ),
    );
  }
}



