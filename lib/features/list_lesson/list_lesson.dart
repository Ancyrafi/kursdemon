import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursdemo/features/list_lesson/cubit/lesson_cubit.dart';
import 'package:kursdemo/features/sections/user_section.dart';

import 'package:kursdemo/repository/repository.dart';

import '../../widgets/title_page_container.dart';

class ListLesson extends StatefulWidget {
  const ListLesson({
    super.key,
  });

  @override
  State<ListLesson> createState() => _ListLessonState();
}

class _ListLessonState extends State<ListLesson> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LessonCubit(Repository())..start(),
      child: BlocBuilder<LessonCubit, LessonState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.errormsg.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errormsg,
                ),
                backgroundColor: Colors.black,
              ),
            );
          }

          final oneLesson = state.lesson;

          return ListView(
            children: [
              const TitlePageContainer(
                title: 'Lekcje',
              ),
              for (final onLesson in oneLesson)
                ExpansionTile(
                  title: Text(onLesson.title),
                  children: [
                    for (final onSection in onLesson.sections)
                      ListTile(
                        title: Text(onSection.title),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => UserSectionPage(
                                    sectionID: onSection.sectionID,
                                    videLink: onSection.link,
                                    sectionTitle: onSection.title,
                                  )));
                        },
                      )
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}
