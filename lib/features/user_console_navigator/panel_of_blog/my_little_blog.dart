import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursdemo/features/user_console_navigator/panel_of_blog/cubit/my_blog_cubit.dart';
import 'package:kursdemo/repository/repository.dart';
import 'package:kursdemo/widgets/build_text_field.dart';

import 'package:quill_html_editor/quill_html_editor.dart';

class MyBlog extends StatelessWidget {
  const MyBlog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final QuillEditorController controller = QuillEditorController();
    final titleController = TextEditingController();
    return BlocProvider(
      create: (context) => MyBlogCubit(Repository())..start(),
      child: BlocBuilder<MyBlogCubit, MyBlogState>(
        builder: (context, state) {
          final blog = state.blogText;
          if (state.addBlog == true) {
            return Card(
              margin: const EdgeInsets.all(30),
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                child: ListView(
                  children: [
                    BuildTextField(
                        hideText: false,
                        hintText: 'Podaj Tytuł bloga',
                        controller: titleController),
                    const SizedBox(
                      height: 10,
                    ),
                    ToolBar(
                      controller: controller,
                      toolBarColor: Colors.blue,
                    ),
                    SingleChildScrollView(
                      child: SizedBox(
                        height: 700,
                        child: QuillHtmlEditor(
                          onEditorResized: (height) => 2,
                          hintTextPadding: const EdgeInsets.all(20),
                          isEnabled: true,
                          backgroundColor: Colors.grey,
                          controller: controller,
                          minHeight: 100,
                          hintText: 'Zacznij tworzyć swój wpis',
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          context.read<MyBlogCubit>().addBlog(
                              blogText: await controller.getText(),
                              title: titleController.text);
                          controller.clear();
                          titleController.clear();
                          context.read<MyBlogCubit>().exit();
                        },
                        child: const Text('Zapisz'))
                  ],
                ),
              ),
            );
          }
          if (state.editBlog == true) {
            return ListView(
              children: [],
            );
          }
          return ListView(
            children: [
              for (final oneBlog in blog)
                ExpansionTile(
                  title: Text(oneBlog.title),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Edytuj'),
                        ),
                        ElevatedButton(
                            onPressed: () {}, child: const Text('Usuń'))
                      ],
                    )
                  ],
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        context.read<MyBlogCubit>().changetoAdd();
                      },
                      child: const Text('Dodaj Wpis'))
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
