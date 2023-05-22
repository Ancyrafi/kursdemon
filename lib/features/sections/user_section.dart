import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

class UserSectionPage extends StatelessWidget {
  const UserSectionPage(
      {super.key,
      required this.sectionID,
      required this.sectionTitle,
      required this.videLink});

  final String sectionID;
  final String sectionTitle;
  final String videLink;
  @override
  Widget build(BuildContext context) {
    final controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube(videLink),
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
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
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
                      backgroundColor: Colors.blueGrey),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Ukończone'))
          ],
        ),
      ),
    );
  }
}
