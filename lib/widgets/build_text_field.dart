import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  const BuildTextField({
    required this.hintText,
    super.key,
  });
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: TextField(
        decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.blueGrey,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      ),
    );
  }
}
