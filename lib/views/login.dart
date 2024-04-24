import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/LoginController.dart';
import 'package:flutter_application_1/configs/constant.dart';
import 'package:flutter_application_1/pag/get.dart';
import 'package:flutter_application_1/pag/home.dart';
import 'package:flutter_application_1/views/custombutton.dart';
import 'package:flutter_application_1/customtext.dart';
import 'package:flutter_application_1/customtextfield.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'usermodel.dart';

final TextEditingController usernameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

LoginController loginController = Get.put(LoginController());

class Login extends StatelessWidget {
  const Login({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Customtext(
            label: "NOTEPAD",
            labelColor: appWhite,
            fontsize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 244, 108, 154),
        foregroundColor: appWhite,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/Notes icon.jpeg",
                  height: 80,
                  width: 80,
                ),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Customtext(
                    label: "Login Screen",
                    fontsize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Customtext(
                label: "Welcome back you!",
                fontsize: 30,
                fontWeight: FontWeight.normal,
                labelColor: Color.fromARGB(255, 244, 108, 154),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Customtext(
                  label: "Username",
                  labelColor: Color.fromARGB(255, 244, 108, 154),
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomTextField(
                customTextFieldController: usernameController,
                hintText: "Enter your username",
                prefixIcon: const Icon(Icons.person),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Customtext(
                  label: "Password",
                  labelColor: Color.fromARGB(255, 244, 108, 154),
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomTextField(
                customTextFieldController: passwordController,
                hintText: "Enter your password",
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: const Icon(Icons.visibility),
                obscuredPassword: true,
                isPassword: true,
              ),
              CustomTextButton(
                buttonName: "Log In",
                color: const Color.fromARGB(255, 244, 108, 154),
                textColor: Colors.white,
                action: () => remoteLogin(context),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/Registrationscreen');
                },
                child: const Customtext(
                  label: "Not a member? Sign up.",
                  labelColor: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontsize: 16,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/forgot');
                },
                child: const Customtext(
                  label: "Forgot password?",
                  labelColor: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontsize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//  Future<void> remoteLogin(BuildContext context) async {
//   String username = usernameController.text.trim();
//   String password = passwordController.text.trim();

//   if (username.isEmpty || password.isEmpty) {
//     print("Username or password is empty");
//     return;
//   }

//   try {
//     http.Response response = await http.post(
//       Uri.parse('http://acs314flutter.xyz/acs314_debra/Notes/login.php'),
//       body: {
//         'username': username,
//         'password': password,
//       },
//     );
//     // http.Response response = await http.get(Uri.parse(
//     //        "http://acs314flutter.xyz/acs314_debra/Notes/login.php?username=$username&password=$password"));

//     if (response.statusCode == 200) {
//       var serverResponse = json.decode(response.body);
//       //print();
//      int loginStatus = serverResponse['success'] ?? 0; // Default to 0 if 'success' key is missing

//       if (loginStatus == 1) {
//         print(username);
//         print("Login Successful");
//         var userData = serverResponse['data'];
//        UserModel user = UserModel.fromJson(userData);
//         loginController.updateUsername(user.username);
//         print(user.username);
//         print(userData);
//         //Get.to(()=> Dashboard());
//         //Navigator.push(context, MaterialPageRoute(builder: (context) => const Dashboard()));
//         // Get.to(()=> Dashboard(), arguments: user);
//         Get.toNamed('/home');
//       } else {
//         print(serverResponse['message']); // Print error message from server
//       }
//     } else {
//       print("Server Error ${response.statusCode}");
//     }
//   } catch (e) {
//     print("Error: $e");
//   }
// }

  Future<void> remoteLogin(BuildContext context) async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      print("Username or password is empty");
      return;
    }

    try {
      http.Response response = await http.post(
        Uri.parse(
            'http://testflutter.felixeladi.co.ke/DebraSystem/login.php?username=$username&password=$password'),
      );

      if (response.statusCode == 200) {
        var serverResponse = json.decode(response.body);
        int loginStatus = serverResponse['success'] ??
            0; // Default to 0 if 'success' key is missing

        // if (loginStatus == 1) {
        //   print(username);
        //   print("Login Successful");
        //   var userData = serverResponse['data'];
        //   print("User Data: $userData"); // Debug output

        //   Navigator.push(context, MaterialPageRoute(builder: (context) => const Dashboard()));
        if (loginStatus == 1) {
          //print(username);
          print("Login Successful");
          var userData = serverResponse['userdata'];
          print("User Data: $userData"); // Debug output
          String username = userData[0]['username'];
          String email = userData[0]['email'];
          //loginController.username.value;
          loginController.updateUsername(username);
          loginController.updateEmail(email);

          Get.to(() => Dashboard());
        } else {
          print(serverResponse['message']); // Print error message from server
        }
      } else {
        print("Server Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
