import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kursdemo/widgets/title_page_container.dart';
import 'package:pod_player/pod_player.dart';

class SectionPanel extends StatelessWidget {
  const SectionPanel(
      {super.key,
      required this.sectionID,
      required this.videoLink,
      required this.sectionTitle});
  final String sectionID;
  final String videoLink;
  final String sectionTitle;

  @override
  Widget build(BuildContext context) {
    final controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube(videoLink),
        podPlayerConfig: const PodPlayerConfig(
          videoQualityPriority: [720, 360],
          autoPlay: false,
        ))
      ..initialise();

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(sectionTitle)),
      ),
      body: Card(
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
            ],
          ),
        ),
      ),
    );
  }
}
