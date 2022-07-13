import 'package:flutter/material.dart';

class PushReplacementButton extends StatelessWidget {

  final String buttonText;
  final Function onPressed;

  const PushReplacementButton({
    Key? key,
    required this.buttonText,
    required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.015,
      ),
      child: ElevatedButton(
        onPressed: () => onPressed(),
        child: Text(
          buttonText,
          //style: textBoldStyle(),
        ),
        //style: buttonStyle(),
      ),
    );
  }
}