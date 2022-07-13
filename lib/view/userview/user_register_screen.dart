import 'package:manjhi/controller/local_storage_controller.dart';
import 'package:manjhi/controller/locationcontroller/location_controller.dart';
import 'package:manjhi/controller/usercontroller/user_controller.dart';
import 'package:manjhi/view/mainview/main_navigate.dart';
import 'package:manjhi/view/util/widget/custom_count_widget.dart';
import 'package:manjhi/view/util/widget/custom_text_form_field_widget.dart';
import 'package:manjhi/view/util/widget/push_replacement_button_widget.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class UserRegisterScreen extends StatefulWidget {
  const UserRegisterScreen({Key? key}) : super(key: key);
  static String id = 'UserRegisterScreen';

  @override
  State<UserRegisterScreen> createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {

  final _formNewUserRegister = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async{
    Provider.of<LocationController>(context,listen: false).determinePosition();
  }

  bool _validateLocation() {
    if (Provider.of<LocationController>(context,listen: false).address.isNotEmpty &&
        Provider.of<LocationController>(context,listen: false).area.isNotEmpty &&
        Provider.of<LocationController>(context,listen: false).district.isNotEmpty &&
        Provider.of<LocationController>(context,listen: false).state.isNotEmpty &&
        Provider.of<LocationController>(context,listen: false).country.isNotEmpty){
      return true;
    }
    return false;
  }

  Future<bool> _registerUser() async {
    Provider.of<UserContoller>(context,listen: false).user.setAddress(Provider.of<LocationController>(context,listen: false).address);
    Provider.of<UserContoller>(context,listen: false).user.setArea(Provider.of<LocationController>(context,listen: false).area);
    Provider.of<UserContoller>(context,listen: false).user.setDistrict(Provider.of<LocationController>(context,listen: false).district);
    Provider.of<UserContoller>(context,listen: false).user.setState(Provider.of<LocationController>(context,listen: false).state);
    Provider.of<UserContoller>(context,listen: false).user.setCountry(Provider.of<LocationController>(context,listen: false).country);
    return await Provider.of<UserContoller>(context,listen: false).registerUser();
  }

  void _moveToNextScreen(bool response) {
    if (response){
      Provider.of<LocalStorageController>(context,listen: false).saveCredentials(
          Provider.of<UserContoller>(context,listen: false).user.getMobileNumber
      );
      Navigator.pushReplacementNamed(context, MainNavigate.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Register'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formNewUserRegister,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              CustomTextFormField(
                icon: const FaIcon(Icons.call),
                secureText: false,
                keyboardType: TextInputType.number,
                labelText: 'Mobile Number',
                saveUserInput: Provider.of<UserContoller>(context,listen: false).user.setMobileNumber,
              ),
              CustomTextFormField(
                icon: const FaIcon(Icons.person),
                secureText: false,
                keyboardType: TextInputType.text,
                labelText: 'Name',
                saveUserInput: Provider.of<UserContoller>(context,listen: false).user.setName,
              ),
              CustomCount(
                labelText: 'Baby',
                saveUserInput: Provider.of<UserContoller>(context,listen: false).user.setBaby,
              ),
              CustomCount(
                labelText: 'Child',
                saveUserInput: Provider.of<UserContoller>(context,listen: false).user.setChild,
              ),
              CustomCount(
                labelText: 'Adult',
                saveUserInput: Provider.of<UserContoller>(context,listen: false).user.setAdult,
              ),
              CustomCount(
                labelText: 'Senior Citizen',
                saveUserInput: Provider.of<UserContoller>(context,listen: false).user.setSenior,
              ),
              CustomCount(
                labelText: 'Physically-Challenged',
                saveUserInput: Provider.of<UserContoller>(context,listen: false).user.setPh,
              ),
              PushReplacementButton(
                buttonText: 'Register',
                onPressed: () async {
                  if (_formNewUserRegister.currentState!.validate()) {
                    if (!_validateLocation()){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please wait, we are fetching your best location')),
                      );
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Raise a request in case of any support from administration')),
                      );
                    }
                    bool response = await _registerUser();
                    _moveToNextScreen(response);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
