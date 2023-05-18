import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursdemo/features/user_console_navigator/panel_of_lesson/cubit/lesson_panel_cubit.dart';
import 'package:kursdemo/repository/repository.dart';
import 'package:kursdemo/widgets/title_page_container.dart';

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
    return BlocProvider(
      create: (context) => LessonPanelCubit(Repository())..start(),
      child: BlocBuilder<LessonPanelCubit, LessonPanelState>(
        builder: (context, state) {
          if (state.addLesson == false && state.addSection == false) {
            final oneLesson = state.lesson;
            return Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TitlePageContainer(title: 'Twoja Lista Lekcji'),
                    Expanded(
                      child: ListView(
                        children: [
                          for (final onLesson in oneLesson)
                            ExpansionTile(
                              childrenPadding: EdgeInsets.zero,
                              expandedAlignment: Alignment.center,
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.center,
                              tilePadding: EdgeInsets.zero,
                              iconColor: Colors.black,
                              title: Text('---> ${onLesson.title}'),
                              children: [
                                for (final onSection in onLesson.sections)
                                  ListTile(
                                    title: Text('--> ${onSection.title}'),
                                  ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<LessonPanelCubit>()
                                          .addSection(onLesson.lessonID);
                                    },
                                    child: const Text('Dodaj Sekcje'))
                              ],
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<LessonPanelCubit>()
                                            .addLesson(true);
                                      },
                                      child: const Text('Dodaj Lekcję'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: const Text('Usuń Lekcję'),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          // Dodawanie Sekcji
          if (state.addSection == true && state.addLesson == false) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Dodawanie Sekcji'),
                  const SizedBox(
                    height: 10,
                  ),
                  BuildTextField(
                      hideText: false,
                      hintText: 'Podaj tytuł sekcji dla twojej lekcji',
                      controller: sectionTitle),
                  const SizedBox(
                    height: 10,
                  ),
                  BuildTextField(
                      hideText: false,
                      hintText: 'Wklej link do twojego filmu',
                      controller: videoLink),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (sectionTitle.text.isNotEmpty &&
                            videoLink.text.isNotEmpty) {
                          context.read<LessonPanelCubit>().createSection(
                              lessonID: state.lessonID,
                              sublessonTitle: sectionTitle.text,
                              videoLink: videoLink.text);
                          sectionTitle.clear();
                          videoLink.clear();
                          context.read<LessonPanelCubit>().exit();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Musisz wypełnić wszystkie pola!'),
                            ),
                          );
                        }
                      },
                      child: const Text('Dodaj Sekcję'))
                ]);
          }
          // Dodawanie Lekcji
          return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
            ElevatedButton(
              onPressed: () {
                if (lessonTitle.text.isNotEmpty) {
                  context
                      .read<LessonPanelCubit>()
                      .createLesson(lessonTitle.text);
                  lessonTitle.clear();
                  context.read<LessonPanelCubit>().exit();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Nie podałeś żadnego tytułu lekcji'),
                    ),
                  );
                }
              },
              child: const Text('Stwórz Lekcję'),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: IconButton(
                  onPressed: () {
                    context.read<LessonPanelCubit>().addLesson(false);
                  },
                  icon: const Icon(Icons.arrow_back)),
            )
          ]);
        },
      ),
    );
  }
}
