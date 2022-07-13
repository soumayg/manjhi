import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DropdownOption extends StatefulWidget {

  final FaIcon icon;
  final String labelText;
  String defaultValue;
  final List<String> optionList;
  final Function setValue;

  DropdownOption(
      {Key? key, required this.icon,
      required this.labelText,
      required this.defaultValue,
      required this.optionList,
      required this.setValue}) : super(key: key);

  @override
  State<DropdownOption> createState() => _DropdownOptionState();
}

class _DropdownOptionState extends State<DropdownOption> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.08,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      child: Row(
        children: [
          widget.icon,
          Text('  ${widget.labelText}'),
          const Spacer(),
          DropdownButton<String>(
            value: widget.defaultValue,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              //color: appBarTheme.keys.first,
            ),
            onChanged: (String? newValue) {
              setState(() {
                widget.defaultValue = newValue!;
                widget.setValue(widget.defaultValue);
              });
            },
            items: widget.optionList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
