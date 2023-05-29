import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:kursdemo/features/blog/cubit/blog_cubit.dart';
import 'package:kursdemo/repository/repository.dart';


class MyBlog extends StatelessWidget {
  const MyBlog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlogCubit(Repository())..start(),
      child: BlocBuilder<BlogCubit, BlogState>(
        builder: (context, state) {
          final blog = state.blog;

          return ListView(
            children: [
              const Text('Mój Blog'),
              for (final oneBlog in blog)
                Card(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    child: HtmlWidget(
                      oneBlog.blogText,
                      customStylesBuilder: (element) {
                        if (element.classes.contains('foo')) {
                          return {'color': 'red'};
                        }

                        return null;
                      },
                      textStyle: const TextStyle(fontSize: 20),
                      renderMode: RenderMode.column,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
