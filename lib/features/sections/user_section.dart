// import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_webview/fwfh_webview.dart';

// import 'package:pod_player/pod_player.dart';

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
                child: Center(
                  child: HtmlWidget(
                    '<iframe width="560" height="315" src="$videLink" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>',
                    factoryBuilder: () => MyWidgetFactory(),
                  ),
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

class MyWidgetFactory extends WidgetFactory with WebViewFactory {
  // optional: override getter to configure how WebViews are built
  @override
  bool get webViewMediaPlaybackAlwaysAllow => true;
  @override
  bool get webView => true;
}
