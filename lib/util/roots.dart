import 'package:flutter/material.dart';
import 'package:flutter_application_1/pag/home.dart';

import 'package:flutter_application_1/theme/theme.dart';
import 'package:flutter_application_1/theme/theme_provider.dart';
import 'package:flutter_application_1/views/changepassword.dart';

import 'package:flutter_application_1/views/forgotpassword.dart';
import 'package:flutter_application_1/views/login.dart';
import 'package:flutter_application_1/views/reg.dart';
import 'package:flutter_application_1/views/settings.dart';
import 'package:get/get.dart';

class Routes{
  static var routes=[
    GetPage(name: '/',page: ()=>Login()),
     GetPage(name: '/Registrationscreen',page: ()=>RegistrationScreen()),
    
    GetPage(name: '/home', page: ()=> Dashboard()),
    GetPage(name: '/settings', page:() => SettingsScreen()),
    GetPage(name: '/forgot', page:() => ForgotPasswordPage()),
    GetPage(name: '/theme', page:() => ThemePage()),
    GetPage(name: '/changepassword', page:() => ChangePasswordPage()),
    
    
  ];
}