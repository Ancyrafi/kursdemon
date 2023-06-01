import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_webview/fwfh_webview.dart';
import 'package:kursdemo/features/user_console_navigator/panel_of_lesson/cubit/lesson_panel_cubit.dart';
import 'package:kursdemo/features/user_console_navigator/panel_of_sections/cubit/panel_sections_cubit.dart';
import 'package:kursdemo/repository/repository.dart';

import 'package:kursdemo/widgets/title_page_container.dart';

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
                        child: HtmlWidget(
                      '<iframe width="560" height="315" src="$videoLink" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>',
                      factoryBuilder: () => MyWidgetFactory(),
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      onPressed: () {
                        context.read<PanelSectionsCubit>().deleteSections(
                            sectionID: sectionID, lessonID: lessonID);
                        Navigator.of(context).pop();
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

class MyWidgetFactory extends WidgetFactory with WebViewFactory {
  // optional: override getter to configure how WebViews are built
  @override
  bool get webViewMediaPlaybackAlwaysAllow => true;
  @override
  bool get webView => true;
}
