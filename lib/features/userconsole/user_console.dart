import 'package:flutter/material.dart';

import '../../widgets/build_text_field.dart';

class UserConsole extends StatefulWidget {
  const UserConsole({super.key});

  @override
  State<UserConsole> createState() => _UserConsoleState();
}

final _scaffoldKey = GlobalKey<ScaffoldState>();
int index = 0;

class _UserConsoleState extends State<UserConsole> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
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
              title: const Text('Dodaj Użytkownika'),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: userControlOption(index),
        ),
      ),
    );
  }

  List<Widget> userControlOption(int index) {
    switch (index) {
      case 0:
        return [
          const Text('Witaj w Panelu Administracyjnym'),
        ];
      case 1:
        return [
          const Text('Dodawanie Użytkownika'),
          const BuildTextField(hintText: 'Podaj E-mail Użytkownika',)
        ];
      case 2:
        return [
          const Text('Dodawanie Lekcji'),
        ];
      case 3:
        return [
          const Text('Dodawanie Sekcji'),
        ];
      case 4:
        return [
          const Text('Wpis na Blog'),
        ];
      case 5:
        return [
          const Text('Dodawanie SocialMedia'),
        ];
      default:
        return [];
    }
  }
}


