import 'package:manjhi/controller/usercontroller/user_request.dart';
import 'package:manjhi/model/usermodel/user_model.dart';
import 'package:flutter/material.dart';

class UserContoller extends ChangeNotifier{
 UserRequest request = UserRequest();
 User user = User();

 Future<bool> registerUser() async{
   bool address = false, family = false;
    int response = await request.userRegisterRequestAPI(user);
    if (response == 201){
      address = await _addressUser();
      family = await _familyUser();
    }
    if (response == 201 && address && family){
      return true;
    }
    return false;
 }

 Future<bool> _addressUser() async{
   int response = await request.userAddressRequestAPI(user);
   return response == 201 ? true: false;
 }

 Future<bool> _familyUser() async{
   int response = await request.userFamilyRequestAPI(user);
   return response == 201 ? true: false;
 }

}