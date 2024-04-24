import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constant.dart';
import 'package:flutter_application_1/customtext.dart';

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Customtext(
            label: "NOTEPAD",
            labelColor: appWhite,
            fontsize: 28, fontWeight: FontWeight.bold,
            
          ),
        ),
        backgroundColor: Color.fromARGB(255, 244, 108, 154),
        foregroundColor: appWhite,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter your email to reset password',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email),
              ),
              // You can handle email validation and state management here
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Implement password reset logic here
                // This could involve sending a password reset link to the entered email
              },
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Forgot Password Demo',
    theme: ThemeData(
      primarySwatch: Colors.pink,
    ),
    home: ForgotPasswordPage(),
  ));
}
