import 'package:flutter/material.dart';

import 'package:quill_html_editor/quill_html_editor.dart';

class MyBlog extends StatelessWidget {
  const MyBlog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final QuillEditorController controller = QuillEditorController();
    return ListView();
  }
}


// Card(
//       margin: const EdgeInsets.all(30),
//       child: Container(
//         padding: const EdgeInsets.all(10),
//         margin: const EdgeInsets.all(10),
//         child: ListView(
//           children: [
//             ToolBar(
//               controller: controller,
//               toolBarColor: Colors.blue,
//             ),
//             SingleChildScrollView(
//               child: SizedBox(
//                 height: 700,
//                 child: QuillHtmlEditor(
//                   onEditorResized: (height) => 2,
//                   hintTextPadding: const EdgeInsets.all(20),
//                   isEnabled: true,
//                   backgroundColor: Colors.grey,
//                   controller: controller,
//                   minHeight: 100,
//                   hintText: 'Zacznij tworzyć swój wpis',
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );