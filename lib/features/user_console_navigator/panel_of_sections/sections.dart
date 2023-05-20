import 'package:flutter/material.dart';

class SectionPanel extends StatelessWidget {
  const SectionPanel(
      {super.key,
      required this.sectionID,
      required this.videoLink,
      required this.sectionTitle});
  final String sectionID;
  final String videoLink;
  final String sectionTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(sectionTitle)),
      ),
      body: Card(
        child: Column(
          children: const [],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
