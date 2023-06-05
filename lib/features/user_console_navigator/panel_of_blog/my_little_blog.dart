import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kursdemo/features/user_console_navigator/panel_of_blog/cubit/my_blog_cubit.dart';
import 'package:kursdemo/features/user_console_navigator/panel_of_blog/edit_view.blog.dart';
import 'package:kursdemo/repository/repository.dart';
import 'package:kursdemo/widgets/build_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
                        hintText: AppLocalizations.of(context)!.titleBlog,
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
                          hintText: AppLocalizations.of(context)!.hintBlogText,
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
                            child: Text(AppLocalizations.of(context)!.saveButton)),
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
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditBlogContent(
                                    blogID: oneBlog.blogID,
                                    blogText: oneBlog.blogText,
                                    title: oneBlog.title)));
                          },
                          child: Text(AppLocalizations.of(context)!.editButton),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<MyBlogCubit>()
                                  .deleteBlog(blogID: oneBlog.blogID);
                            },
                            child: Text(AppLocalizations.of(context)!.deleteButtton))
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
                      child: Text(AppLocalizations.of(context)!.addBlogButton))
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
