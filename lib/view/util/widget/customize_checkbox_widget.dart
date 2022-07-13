import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomCheckbox extends StatefulWidget {
  final FaIcon icon;
  final String text;
  final bool defaultValue;
  final Function onChanged;

  const CustomCheckbox({
    Key? key,
    required this.icon,
    required this.text,
    required this.defaultValue,
    required this.onChanged})
      : super(key: key);

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
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
          Text('  ${widget.text}',),
          const Spacer(),
          Checkbox(
            value: widget.defaultValue,
            onChanged: (bool? value){
              widget.onChanged(value!);
            },
          )
        ],
      ),
    );
  }
}
