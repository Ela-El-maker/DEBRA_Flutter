import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/customtext.dart';
import 'package:flutter_application_1/customtextfield.dart';
import 'package:flutter_application_1/views/custombutton.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration Screen',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _secondnameController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reenterpasswordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  bool isChecked = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Customtext(
            label: "NOTE",
            labelColor: Color.fromARGB(255, 244, 108, 154),
            fontsize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Customtext(
                label: 'First Name',
                labelColor: Color.fromARGB(255, 244, 108, 154),
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                customTextFieldController: _firstnameController,
                hintText: "Enter your first name",
                prefixIcon: const Icon(Icons.person),
              ),
              const Customtext(
                label: 'Last Name',
                labelColor: Color.fromARGB(255, 244, 108, 154),
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 12),
              CustomTextField(
                customTextFieldController: _secondnameController,
                hintText: "Enter your last name",
                prefixIcon: const Icon(Icons.person),
              ),
              Customtext(
                  label: 'Phone number',
                  labelColor: Color.fromARGB(255, 244, 108, 154),
                  fontWeight: FontWeight.bold),
              SizedBox(height: 12),
              CustomTextField(
                customTextFieldController: _phonenumberController,
                hintText: "something of this sort 0712345677",
                prefixIcon: const Icon(Icons.phone),
              ),
              Customtext(
                label: 'Email',
                labelColor: Color.fromARGB(255, 244, 108, 154),
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 12),
              CustomTextField(
                customTextFieldController: _emailController,
                hintText: "Enter your email",
                prefixIcon: const Icon(Icons.email),
              ),
              Customtext(
                label: 'Password',
                labelColor: Color.fromARGB(255, 244, 108, 154),
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 12),
              CustomTextField(
                customTextFieldController: _passwordController,
                hintText: "Enter your password",
                prefixIcon: const Icon(Icons.lock),
                obscuredPassword: true,
                isPassword: true,
              ),
              Customtext(
                label: 'Re-enter Password',
                labelColor: Color.fromARGB(255, 244, 108, 154),
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 12),
              CustomTextField(
                customTextFieldController: _reenterpasswordController,
                hintText: "Re-enter your password",
                prefixIcon: const Icon(Icons.lock),
                obscuredPassword: true,
                isPassword: true,
              ),
              Customtext(
                label: 'Username',
                labelColor: Color.fromARGB(255, 244, 108, 153),
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 12),
              CustomTextField(
                customTextFieldController: _usernameController,
                hintText: "Enter your username",
                prefixIcon: const Icon(Icons.verified_user_rounded),
              ),
              CustomTextButton(
                buttonName: "Register",
                color: Color.fromARGB(255, 244, 108, 154),
                textColor: Colors.white,
                action: remoteRegister,
              ),
            
              if (errorMessage.isNotEmpty) // Show error message if not empty
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    errorMessage,
                    style: TextStyle(color: Color.fromARGB(255, 159, 18, 8)),
                  ),
                ),
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  const Text("I have read and I agree to the terms and conditions"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _register() {
    // Reset error message
    setState(() {
      errorMessage = '';
    });

    // Check if any field is empty
    if (_firstnameController.text.isEmpty ||
        _secondnameController.text.isEmpty ||
        _phonenumberController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _reenterpasswordController.text.isEmpty ||
        _usernameController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please fill in all fields';
      });
      return;
    }

    // Validate password strength
    if (!_isPasswordStrong(_passwordController.text)) {
      setState(() {
        errorMessage = 'Password is not strong enough';
      });
      return;
    }

    // Check if passwords match
    if (_passwordController.text != _reenterpasswordController.text) {
      setState(() {
        errorMessage = 'Passwords do not match';
      });
      return;
    }

    // If everything is okay, proceed with registration
    // remoteRegister();
  }

  bool _isPasswordStrong(String password) {
    // Implement your password strength checking logic here
    // Return true if the password meets your criteria for strength, false otherwise
    // Example: check length, presence of special characters, etc.
    return password.length >= 8; // Example: Minimum length of 8 characters
  }

 Future<void> remoteRegister() async {
  try {
    http.Response response;
    var body = {
      'firstname': _firstnameController.text.trim(),
      'secondname': _secondnameController.text.trim(),
      'phone': _phonenumberController.text.trim(),
      'email': _emailController.text.trim(),
      'password': _passwordController.text.trim(),
      'username': _usernameController.text.trim(),
    };
    response = await http.post(
      Uri.parse("http://testflutter.felixeladi.co.ke/DebraSystem/register.php"),
      body: body,
    );
    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    // Handle response
    if (response.statusCode == 200) {
      if (response.body.contains("New record created successfully")) {
        // Registration success
        Get.toNamed("/");
      } else {
        // Registration failed
        print('Registration failed');
      }
    }
  } catch (e) {
    print('Error: $e');
    // Handle error
  }
}


}



