import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserContent extends StatelessWidget {
  const UserContent({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Panel Użytkownika')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(user?.displayName ?? ''),
          const SizedBox(height: 10,),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pop();
                },
                child: const Text('Wyloguj się')),
          )
        ],
      ),
    );
  }
}
