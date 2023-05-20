import 'package:flutter/material.dart';

import 'package:kursdemo/features/userconsole/user_console.dart';

import '../list_lesson/list_lesson.dart';
import '../socialmedia/socialmedia.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(9.0),
                    backgroundColor: Colors.black,
                    minimumSize: const Size(10, 10)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const UserConsole()));
                },
                child: const Icon(
                  Icons.supervised_user_circle,
                  color: Colors.white,
                ))
          ],
          backgroundColor: const Color.fromARGB(174, 48, 46, 59),
          title: const Center(child: Text('     Nazwa Kursu')),
        ),
        body: const Card(
          margin: EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: ListLesson(),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Mój Blog'),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: SocialMedia(),
              ),
            ],
          ),
        ));
  }
}
