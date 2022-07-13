import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTextFormField extends StatelessWidget {
  final FaIcon icon;
  final bool secureText;
  final TextInputType keyboardType;
  final String labelText;
  final Function saveUserInput;

  const CustomTextFormField(
      {Key? key,
        required this.icon,
        required this.secureText,
        required this.keyboardType,
        required this.labelText,
        required this.saveUserInput})
      : super(key: key);

  int _maxLinesCheck() {
    switch(labelText){
      case 'Request Description':
        return 10;
    }
    return 1;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.08,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      child: TextFormField(
        maxLines: _maxLinesCheck(),
        obscureText: secureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          icon: icon,
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        validator: (value) {
          if (labelText.contains('Password')) {
            if (value!.length < 8) {
              return 'Password should have minimum 8 characters !';
            }
          }
          else if (labelText.contains('Mobile Number')) {
            if (value!.length != 10) {
              return 'Mobile Number should have 10 digits !';
            }
          }
          else if (value == null || value.isEmpty) {
            return '$labelText !';
          }
          saveUserInput(value);
          return null;
        },
      ),
    );
  }
}