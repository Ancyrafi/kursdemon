import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursdemo/features/user_console_navigator/panel_of_lesson/cubit/lesson_panel_cubit.dart';
import 'package:kursdemo/features/user_console_navigator/panel_of_sections/cubit/panel_sections_cubit.dart';
import 'package:kursdemo/repository/repository.dart';
import 'package:kursdemo/widgets/title_page_container.dart';
import 'package:pod_player/pod_player.dart';

class SectionPanel extends StatelessWidget {
  const SectionPanel(
      {super.key,
      required this.lessonID,
      required this.sectionID,
      required this.videoLink,
      required this.sectionTitle});
  final String sectionID;
  final String videoLink;
  final String sectionTitle;
  final String lessonID;

  @override
  Widget build(BuildContext context) {
    final controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube(videoLink),
        podPlayerConfig: const PodPlayerConfig(
          videoQualityPriority: [720, 360],
          autoPlay: false,
        ))
      ..initialise();

    return BlocProvider(
      create: (context) => PanelSectionsCubit(Repository()),
      child: BlocBuilder<PanelSectionsCubit, PanelSectionsState>(
        builder: (context, state) {
          if (state.delete == true) {
            context.read<LessonPanelCubit>().exit();
            Navigator.of(context).pop();
          }
          return Scaffold(
            appBar: AppBar(
              title: Center(child: Text(sectionTitle)),
            ),
            body: Card(
              margin: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.all(30),
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitlePageContainer(title: sectionTitle),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: PodVideoPlayer(
                        controller: controller,
                        podProgressBarConfig: const PodProgressBarConfig(
                          padding: kIsWeb
                              ? EdgeInsets.zero
                              : EdgeInsets.only(
                                  bottom: 20,
                                  right: 20,
                                  left: 20,
                                ),
                          playingBarColor: Colors.blue,
                          circleHandlerColor: Colors.blue,
                          backgroundColor: Colors.blueGrey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      onPressed: () {
                        context.read<PanelSectionsCubit>().deleteSections(
                            sectionID: sectionID, lessonID: lessonID);
                      },
                      child: const Text('Usuń sekcję'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
