import 'package:flutter/material.dart';

import 'package:kursdemo/widgets/title_page_container.dart';

class MyBlog extends StatelessWidget {
  const MyBlog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const TitlePageContainer(title: 'Kreator twojego Bloga'),
      Card(
        margin: const EdgeInsets.all(30),
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          child: const Column(),
        ),
      ),
    ]);
  }
}
