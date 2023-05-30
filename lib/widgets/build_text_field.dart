import 'package:flutter/material.dart';

class BuildTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool hideText;
  final bool enabled;

  const BuildTextField({
    required this.enabled,
    required this.hideText,
    required this.hintText,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  State<BuildTextField> createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: TextField(
        enabled: widget.enabled,
        obscureText: widget.hideText,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
          filled: true,
          fillColor: Colors.blueGrey,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    );
  }
}
