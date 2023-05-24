import 'package:flutter/material.dart';

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              icon: const Icon(Icons.menu),
            ),
            const Text('Administracja'),
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
              title: const Text('Dodaj Wpis na Blog'),
              onTap: () {
                setState(() {
                  index = 3;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Dodaj SocialMedia'),
              onTap: () {
                setState(() {
                  index = 4;
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
        return const Column(children: [
          Text('Witaj w Panelu Administracyjnym'),
        ]);
      case 1:
        // Zarządzanie Użytkownikami
        return const AddUsers();

      case 2:
        // Zarządzanie Lekcjami
        return const LessonPanel();

      case 3:
        // Blog
        return const Column(children: [
          Text('Wpis na Blog'),
        ]);
      case 4:
        // Social Media
        return const Column(children: [
          Text('Dodawanie SocialMedia'),
        ]);
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }
}
