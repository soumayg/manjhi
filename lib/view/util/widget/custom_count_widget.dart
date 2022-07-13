// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomCount extends StatefulWidget {
  final String labelText;
  final Function saveUserInput;

  const CustomCount(
      {Key? key, required this.labelText, required this.saveUserInput})
      : super(key: key);

  @override
  State<CustomCount> createState() => _CustomCountState();
}

class _CustomCountState extends State<CustomCount> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.08,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      child: Row(
        children: [
          Text(
            widget.labelText,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
            onPressed: (){
              if (count>0){
                --count;
                setState(() {});
                widget.saveUserInput(count);
              }
            },
            icon: const Icon(Icons.remove),
          ),
          Text(count.toString()),
          IconButton(
            onPressed: (){
              count++;
              setState(() {});
              widget.saveUserInput(count);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
