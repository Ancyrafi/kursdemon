import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kursdemo/features/user_console_navigator/panel_of_lesson/cubit/lesson_panel_cubit.dart';
import 'package:kursdemo/features/user_console_navigator/panel_of_sections/sections.dart';
import 'package:kursdemo/repository/repository.dart';
import 'package:kursdemo/widgets/convert_to_embed.dart';
import 'package:kursdemo/widgets/title_page_container.dart';

import '../../../widgets/build_text_field.dart';

class LessonPanel extends StatefulWidget {
  const LessonPanel({
    super.key,
  });

  @override
  State<LessonPanel> createState() => _LessonPanelState();
}

class _LessonPanelState extends State<LessonPanel> {
  final lessonTitle = TextEditingController();

  final sectionTitle = TextEditingController();

  final videoLink = TextEditingController();
  String? selectedLessonID;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LessonPanelCubit(Repository())..start(),
      child: BlocBuilder<LessonPanelCubit, LessonPanelState>(
        builder: (context, state) {
          bool fromYouTube = false;
          bool fromGoogleDrive = false;
          if (state.addLesson == false && state.addSection == false) {
            final oneLesson = state.lesson;
            return Container(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(50),
                margin: const EdgeInsets.all(50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TitlePageContainer(title: 'Twoja Lista Lekcji'),
                    Expanded(
                      child: ListView(
                        children: [
                          for (final onLesson in oneLesson)
                            ExpansionTile(
                              textColor: Colors.black,
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
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SectionPanel(
                                                    sectionID:
                                                        onSection.sectionID,
                                                    videoLink: onSection.link,
                                                    sectionTitle:
                                                        onSection.title,
                                                    lessonID: onLesson.lessonID,
                                                  )));
                                    },
                                  ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black),
                                    onPressed: () {
                                      context
                                          .read<LessonPanelCubit>()
                                          .addSection(onLesson.lessonID);
                                    },
                                    child: const Icon(Icons.add))
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
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black),
                                      onPressed: () {
                                        context
                                            .read<LessonPanelCubit>()
                                            .addLesson(true);
                                      },
                                      child: const Text('Dodaj Lekcję'),
                                    ),
                                    Column(
                                      children: [
                                        DropdownButton<String>(
                                            value: selectedLessonID,
                                            hint: const Text('Wybierz lekcję'),
                                            dropdownColor: Colors.black,
                                            items: [
                                              for (final onLesson in oneLesson)
                                                DropdownMenuItem(
                                                  value: onLesson.lessonID,
                                                  child: Text(onLesson.title),
                                                )
                                            ],
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedLessonID = newValue;
                                              });
                                            }),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.black),
                                          onPressed: () {
                                            if (selectedLessonID == null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      backgroundColor:
                                                          Colors.black,
                                                      content: Text(
                                                          'Musisz wybrać lekcję')));
                                            } else {
                                              context
                                                  .read<LessonPanelCubit>()
                                                  .deleteLesson(
                                                      selectedLessonID!);
                                              Navigator.of(context).pop();
                                            }
                                          },
                                          child: const Text('Usuń Lekcję'),
                                        )
                                      ],
                                    ),
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
                      enabled: true,
                      hideText: false,
                      hintText: 'Podaj tytuł sekcji dla twojej lekcji',
                      controller: sectionTitle),
                  const SizedBox(
                    height: 10,
                  ),
                  if (fromYouTube == true) 
                    BuildTextField(
                        enabled: true,
                        hideText: false,
                        hintText: 'Wklej link do twojego filmu z YouTube',
                        controller: videoLink),
                  if (fromGoogleDrive == true)
                    BuildTextField(
                        enabled: true,
                        hideText: false,
                        hintText: 'Wklej link do twojego filmu z Google Drive',
                        controller: videoLink),
                  const SizedBox(
                    height: 10,
                  ),
                  IconButton(
                      onPressed: () {
                        if (fromYouTube == false) {
                          setState(() {
                            fromYouTube = true;
                            fromGoogleDrive = false;
                          });
                        } else {
                          setState(() {
                            fromYouTube = false;
                            fromGoogleDrive = false;
                          });
                        }
                      },
                      icon: const Icon(FontAwesome.youtube)),
                  IconButton(
                      onPressed: () {
                        if (fromGoogleDrive == false) {
                          setState(() {
                            fromYouTube = false;
                            fromGoogleDrive = true;
                          });
                        } else {
                          setState(() {
                            fromYouTube = false;
                            fromGoogleDrive = false;
                          });
                        }
                      },
                      icon: const Icon(FontAwesome.google_plus)),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (sectionTitle.text.isNotEmpty &&
                            videoLink.text.isNotEmpty) {
                          String embedLink = convertEmbed(videoLink.text);
                          context.read<LessonPanelCubit>().createSection(
                              lessonID: state.lessonID,
                              sublessonTitle: sectionTitle.text,
                              videoLink: embedLink);
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
                enabled: true,
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
