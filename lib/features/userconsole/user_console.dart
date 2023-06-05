import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kursdemo/features/authgate/auth.dart';

import '../user_console_navigator/panel_of_blog/my_little_blog.dart';
import '../user_console_navigator/panel_of_lesson/lesson_panel.dart';
import '../user_console_navigator/panel_of_social/panel_of_social.dart';
import '../user_console_navigator/panel_of_users/user_panel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserConsole extends StatefulWidget {
  const UserConsole({super.key});

  @override
  State<UserConsole> createState() => _UserConsoleState();
}

final _scaffoldKey = GlobalKey<ScaffoldState>();
int index = 0;
final sectionTitle = TextEditingController();
final videoLink = TextEditingController();

class _UserConsoleState extends State<UserConsole> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              icon: const Icon(Icons.menu),
            ),
            Text(AppLocalizations.of(context)!.rootPanelTitle),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.home))
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Text(AppLocalizations.of(context)!.rootPanelRollTitle),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.rootPanelRollUser),
              onTap: () {
                setState(() {
                  index = 1;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.rootPanelRollLesson),
              onTap: () {
                setState(() {
                  index = 2;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.rootPanelRollBlog),
              onTap: () {
                setState(() {
                  index = 3;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.rootPanelRollSocial),
              onTap: () {
                setState(() {
                  index = 4;
                });
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.rootPanelRollLogOut),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => AuthGate()));
              },
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Card(
                margin: const EdgeInsets.all(10),
                child: Center(child: userControlOption(index))),
          ),
        ],
      ),
    );
  }

  Widget userControlOption(int index) {
    switch (index) {
      case 0:
        // Indeks Startowy
        return Column(children: [
          Text(AppLocalizations.of(context)!.rootPanelFirstPage),
        ]);
      case 1:
        // Zarządzanie Użytkownikami
        return const AddUsers();

      case 2:
        // Zarządzanie Lekcjami
        return const LessonPanel();

      case 3:
        // Blog
        return const MyBlog();
      case 4:
        // Social Media
        return const PanelSocialMedia();
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }
}
