import 'package:flutter/material.dart';
import 'package:kursdemo/features/user_content/user_contetn.dart';



import '../blog/myblog.dart';
import '../list_lesson/list_lesson.dart';
import '../socialmedia/socialmedia.dart';

class HomePageUser extends StatelessWidget {
  HomePageUser({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(174, 48, 46, 59),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  scaffoldKey.currentState!.openDrawer();
                },
                icon: const Icon(Icons.menu),
              ),
              const Text('Nazwa Kursu'),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(9.0),
                      backgroundColor: Colors.black,
                      minimumSize: const Size(10, 10)),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const UserContent()));
                  },
                  child: const Icon(
                    Icons.supervised_user_circle,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
        drawer: const Drawer(
          child: ListLesson(),
        ),
        body: const Card(
          margin: EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: MyBlog(),
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
