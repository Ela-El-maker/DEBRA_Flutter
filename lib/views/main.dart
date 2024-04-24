import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/roots.dart';

import 'package:get/get.dart';
// ignore: unused_import
import 'package:get/get_connect/http/src/utils/utils.dart';


void main() {
  runApp(GetMaterialApp(
    initialRoute: '/',

    debugShowCheckedModeBanner: false,
    getPages: Routes.routes,
  ));
}



    