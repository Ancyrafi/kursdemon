import 'package:flutter/material.dart';

@immutable
class TitlePageContainer extends StatelessWidget {
  const TitlePageContainer({
    required this.title,
    super.key,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(10.0)),
      child: Center(child: Text(title)),
    );
  }
}
