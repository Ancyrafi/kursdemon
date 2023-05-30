import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursdemo/features/user_console_navigator/panel_of_blog/cubit/my_blog_cubit.dart';
import 'package:kursdemo/repository/repository.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class EditBlogContent extends StatelessWidget {
  const EditBlogContent(
      {required this.blogID,
      required this.blogText,
      required this.title,
      super.key});
  final String blogID;
  final String blogText;
  final String title;

  @override
  Widget build(BuildContext context) {
    final toolbarconfig = [
      ToolBarStyle.bold,
      ToolBarStyle.italic,
      ToolBarStyle.image,
      ToolBarStyle.color,
      ToolBarStyle.underline,
      ToolBarStyle.background,
      ToolBarStyle.strike,
      ToolBarStyle.undo,
      ToolBarStyle.redo,
      ToolBarStyle.clean,
    ];
    final QuillEditorController controller = QuillEditorController();
    return BlocProvider(
      create: (context) => MyBlogCubit(Repository()),
      child: BlocBuilder<MyBlogCubit, MyBlogState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: Card(
              margin: const EdgeInsets.all(10),
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ToolBar(
                        controller: controller,
                        toolBarColor: Colors.blue,
                        toolBarConfig: toolbarconfig,
                      ),
                      SizedBox(
                        height: 400,
                        child: QuillHtmlEditor(
                          text: blogText,
                          onEditorResized: (height) => 2,
                          hintTextPadding: const EdgeInsets.all(20),
                          isEnabled: true,
                          backgroundColor: Colors.grey,
                          controller: controller,
                          minHeight: 500,
                          hintText: 'Zacznij tworzyć swój wpis',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              context.read<MyBlogCubit>().editBlog(
                                  blogText: await controller.getText(),
                                  blogID: blogID);
                              Navigator.of(context).pop();
                            },
                            child: const Text('Zapisz'),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.arrow_back))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
