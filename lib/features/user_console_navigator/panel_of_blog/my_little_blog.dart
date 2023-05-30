import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
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
          if (state.addBlog == true) {
            return Card(
              margin: const EdgeInsets.all(30),
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                child: ListView(
                  children: [
                    BuildTextField(
                        enabled: true,
                        hideText: false,
                        hintText: 'Podaj Tytuł bloga',
                        controller: titleController),
                    const SizedBox(
                      height: 10,
                    ),
                    ToolBar(
                      controller: controller,
                      toolBarColor: Colors.blue,
                      toolBarConfig: toolbarconfig,
                    ),
                    SingleChildScrollView(
                      child: SizedBox(
                        height: 300,
                        child: QuillHtmlEditor(
                          onEditorResized: (height) => 2,
                          hintTextPadding: const EdgeInsets.all(20),
                          isEnabled: true,
                          backgroundColor: Colors.grey,
                          controller: controller,
                          minHeight: 400,
                          hintText: 'Zacznij tworzyć swój wpis',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              context.read<MyBlogCubit>().addBlog(
                                  blogText: await controller.getText(),
                                  title: titleController.text);
                              controller.clear();
                              titleController.clear();
                              context.read<MyBlogCubit>().exit();
                            },
                            child: const Text('Zapisz')),
                        IconButton(
                            onPressed: () {
                              context.read<MyBlogCubit>().exit();
                            },
                            icon: const Icon(FontAwesome.arrow_circle_left))
                      ],
                    )
                  ],
                ),
              ),
            );
          }
          if (state.editBlog == true) {
            return Card(
              margin: const EdgeInsets.all(30),
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                child: ListView(
                  children: [
                    for (final oneBlog in blog)
                      Column(
                        children: [
                          BuildTextField(
                              enabled: false,
                              hideText: false,
                              hintText: oneBlog.title,
                              controller: titleController),
                          const SizedBox(
                            height: 10,
                          ),
                          ToolBar(
                            controller: controller,
                            toolBarColor: Colors.blue,
                            toolBarConfig: toolbarconfig,
                          ),
                          SingleChildScrollView(
                            child: SizedBox(
                              height: 300,
                              child: QuillHtmlEditor(
                                text: oneBlog.blogText,
                                onEditorResized: (height) => 2,
                                hintTextPadding: const EdgeInsets.all(20),
                                isEnabled: true,
                                backgroundColor: Colors.grey,
                                controller: controller,
                                minHeight: 400,
                                hintText: 'Zacznij tworzyć swój wpis',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                  onPressed: () async {
                                    context.read<MyBlogCubit>().editBlog(
                                          blogID: oneBlog.blogID,
                                          blogText: await controller.getText(),
                                        );
                                    controller.clear();
                                    titleController.clear();
                                    context.read<MyBlogCubit>().exit();
                                  },
                                  child: const Text('Zapisz')),
                              IconButton(
                                  onPressed: () {
                                    context.read<MyBlogCubit>().exit();
                                  },
                                  icon:
                                      const Icon(FontAwesome.arrow_circle_left))
                            ],
                          )
                        ],
                      ),
                  ],
                ),
              ),
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
                          onPressed: () {
                            context.read<MyBlogCubit>().changetoEdit();
                          },
                          child: const Text('Edytuj'),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<MyBlogCubit>()
                                  .deleteBlog(blogID: oneBlog.blogID);
                            },
                            child: const Text('Usuń'))
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
