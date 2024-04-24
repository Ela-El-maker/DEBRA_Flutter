import 'package:get/get.dart';

class LoginController extends GetxController{
  var username=''.obs;
var email = ''.obs;
var userId = ''.obs;
  updateUsername(String value){
    username.value = value;
  }
  updateEmail(String value){
    email.value= value;
  }
  updateuserId(var value){
    userId.value = value;
  }
}