import 'package:flutter/material.dart';

import '../../../widgets/build_text_field.dart';

class LessonPanel extends StatelessWidget {
  LessonPanel({
    super.key,
  });

  final lessonTitle = TextEditingController();
  final sectionTitle = TextEditingController();
  final videoLink = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Column(children: [
      const Text('Dodawanie Lekcji'),
      const SizedBox(
        height: 10,
      ),
      BuildTextField(
          hideText: false,
          hintText: 'Podaj tytuł twojej lekcji',
          controller: lessonTitle),
      const SizedBox(
        height: 10,
      ),
      ElevatedButton(onPressed: () {}, child: const Text('Stwórz Lekcję')),
    ]);
  }
}
