import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TextIconRowButton extends StatelessWidget {
  final String header;
  final String? text;
  const TextIconRowButton({Key? key,
    required this.header,
    this.text}) : super(key: key);

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  Widget textIconWidget() {
    return  Flexible(
      child: TextButton(
        onPressed: () => _makePhoneCall(text!),
        child: Text(
          text!,
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.215,
            child: Text(
              '$header ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.03,
            child: const Text(
              ':', style: TextStyle(fontWeight: FontWeight.bold,),
            ),
          ),
          textIconWidget(),
        ],
      ),
    );
  }
}
