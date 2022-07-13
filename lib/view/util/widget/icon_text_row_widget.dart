import 'package:flutter/material.dart';

class TextIconRow extends StatelessWidget {
  final String header;
  final String? text;
  const TextIconRow({Key? key,
    required this.header,
    this.text}) : super(key: key);

  Widget textIconWidget() {
    return  Flexible(
      child: Text(
        text!,
        textDirection: TextDirection.ltr,
        style: const TextStyle(
          color: Colors.black87,
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
            width: MediaQuery.of(context).size.width * 0.02,
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
