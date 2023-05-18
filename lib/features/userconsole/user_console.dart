import 'package:flutter/material.dart';

import '../../widgets/build_text_field.dart';
import '../user_console_navigator/panel_of_lesson/lesson_panel.dart';
import '../user_console_navigator/panel_of_users/user_panel.dart';

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
        title: const Text('Administracja'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              icon: const Icon(Icons.menu))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Panel Zarządzania'),
            ),
            ListTile(
              title: const Text('Zarządzaj Użytkownikami'),
              onTap: () {
                setState(() {
                  index = 1;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Dodaj Lekcje'),
              onTap: () {
                setState(() {
                  index = 2;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Dodaj Sekcje'),
              onTap: () {
                setState(() {
                  index = 3;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Dodaj Wpis na Blog'),
              onTap: () {
                setState(() {
                  index = 4;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Dodaj SocialMedia'),
              onTap: () {
                setState(() {
                  index = 5;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      body: Card(
          margin: const EdgeInsets.all(10),
          child: Center(child: userControlOption(index))),
    );
  }

  Widget userControlOption(int index) {
    switch (index) {
      case 0:
        // Indeks Startowy
        return Column(children: const [
          Text('Witaj w Panelu Administracyjnym'),
        ]);
      case 1:
        // Zarządzanie Użytkownikami
        return const AddUsers();

      case 2:
        // Zarządzanie Lekcjami
        return LessonPanel();
      case 3:
        // Zarządzanie Sekcjami danych Lekcji
        return Column(children: [
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
          ElevatedButton(onPressed: () {}, child: const Text('Dodaj Sekcję'))
        ]);
      case 4:
        // Blog
        return Column(children: const [
          Text('Wpis na Blog'),
        ]);
      case 5:
        // Social Media
        return Column(children: const [
          Text('Dodawanie SocialMedia'),
        ]);
      default:
        return Column(children: const []);
    }
  }
}
