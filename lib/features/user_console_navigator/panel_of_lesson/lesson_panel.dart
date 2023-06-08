import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:kursdemo/features/user_console_navigator/panel_of_lesson/cubit/lesson_panel_cubit.dart';
import 'package:kursdemo/features/user_console_navigator/panel_of_sections/sections.dart';
import 'package:kursdemo/repository/repository.dart';
import 'package:kursdemo/widgets/convert_to_embed.dart';
import 'package:kursdemo/widgets/title_page_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../widgets/build_text_field.dart';

class LessonPanel extends StatefulWidget {
  const LessonPanel({Key? key}) : super(key: key);

  @override
  State<LessonPanel> createState() => _LessonPanelState();
}

class _LessonPanelState extends State<LessonPanel> {
  final lessonTitle = TextEditingController();

  final sectionTitle = TextEditingController();

  final videoLink = TextEditingController();
  final googleLink = TextEditingController();
  String? selectedLessonID;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LessonPanelCubit(Repository())..start2(),
      child: BlocBuilder<LessonPanelCubit, LessonPanelState>(
        builder: (context, state) {
          if (state.addLesson == false && state.addSection == false) {
            final oneLesson = state.lesson;
            final lessonLimit = state.limitLesson;
            final sectionLimit = state.limitSection;
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TitlePageContainer(
                    title: AppLocalizations.of(context)!.listLessonInfo),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(10),
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
                            title: Row(
                              children: [
                                const Icon(FontAwesome.list),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(onLesson.title),
                              ],
                            ),
                            children: [
                              for (final onSection in onLesson.sections)
                                ListTile(
                                  title: Row(
                                    children: [
                                      const Icon(FontAwesome.circle),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(onSection.title),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => SectionPanel(
                                                  sectionID:
                                                      onSection.sectionID,
                                                  videoLink: onSection.link,
                                                  sectionTitle: onSection.title,
                                                  lessonID: onLesson.lessonID,
                                                )));
                                  },
                                ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (sectionLimit == false)
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black),
                                    onPressed: () {
                                      context
                                          .read<LessonPanelCubit>()
                                          .addSection(onLesson.lessonID);
                                    },
                                    child: const Icon(Icons.add)),
                              if (sectionLimit == true)
                                const Text(
                                    'Wykorzystano dostępny limit w tym pakiecie')
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
                                  if (lessonLimit == false)
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black),
                                      onPressed: () {
                                        context
                                            .read<LessonPanelCubit>()
                                            .addLesson(true);
                                      },
                                      child: Text(AppLocalizations.of(context)!
                                          .dodajLekcje),
                                    ),
                                  if (lessonLimit == true)
                                    const Text(
                                        'Wykorzystano dostępny limit w tym pakiecie'),
                                  Column(
                                    children: [
                                      DropdownButton<String>(
                                          value: selectedLessonID,
                                          hint: Text(
                                              AppLocalizations.of(context)!
                                                  .chooseLessonButton),
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
                                                .showSnackBar(SnackBar(
                                                    backgroundColor:
                                                        Colors.black,
                                                    content: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .errorChooseLesson)));
                                          } else {
                                            context
                                                .read<LessonPanelCubit>()
                                                .deleteLesson(
                                                    selectedLessonID!);
                                            Navigator.of(context).pop();
                                          }
                                        },
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .deleteButtton),
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
                ),
              ],
            );
          }
          // Dodawanie Sekcji
          if (state.addSection == true && state.addLesson == false) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.addSectionInfo),
                  const SizedBox(
                    height: 10,
                  ),
                  BuildTextField(
                      enabled: true,
                      hideText: false,
                      hintText: AppLocalizations.of(context)!.addSectionTitle,
                      controller: sectionTitle),
                  const SizedBox(
                    height: 10,
                  ),
                  BuildTextField(
                      enabled: true,
                      hideText: false,
                      hintText:
                          AppLocalizations.of(context)!.addSectionLinkYoutube,
                      controller: videoLink),
                  const SizedBox(
                    height: 10,
                  ),
                  BuildTextField(
                      enabled: true,
                      hideText: false,
                      hintText:
                          AppLocalizations.of(context)!.addSectionLinkGoogle,
                      controller: googleLink),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (sectionTitle.text.isNotEmpty) {
                        if (videoLink.text.isNotEmpty &&
                            googleLink.text.isEmpty) {
                          String embedLink = convertEmbed(videoLink.text);
                          context.read<LessonPanelCubit>().createSection(
                              lessonID: state.lessonID,
                              sublessonTitle: sectionTitle.text,
                              videoLink: embedLink);
                          sectionTitle.clear();
                          videoLink.clear();
                          Navigator.of(context).pop();
                        } else {
                          if (videoLink.text.isNotEmpty &&
                              googleLink.text.isNotEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(AppLocalizations.of(context)!
                                    .sectionErrorMessage),
                              ),
                            );
                          } else {
                            if (videoLink.text.isEmpty &&
                                googleLink.text.isNotEmpty) {
                              String googleEmbed =
                                  convertEmbedfromGoogle(googleLink.text);
                              context.read<LessonPanelCubit>().createSection(
                                  lessonID: state.lessonID,
                                  sublessonTitle: sectionTitle.text,
                                  videoLink: googleEmbed);
                              googleLink.clear();
                              sectionTitle.clear();
                              Navigator.of(context).pop();
                            }
                          }
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(AppLocalizations.of(context)!
                                .sectionErrorMessage2),
                          ),
                        );
                      }
                    },
                    child: const Icon(Icons.add),
                  ),
                ]);
          }
          // Dodawanie Lekcji
          return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(AppLocalizations.of(context)!.lessonInfo),
            const SizedBox(
              height: 10,
            ),
            BuildTextField(
                enabled: true,
                hideText: false,
                hintText: AppLocalizations.of(context)!.lessonAddTitle,
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
                    SnackBar(
                      content: Text(AppLocalizations.of(context)!.errorLesson),
                    ),
                  );
                }
              },
              child: const Icon(Icons.add),
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
