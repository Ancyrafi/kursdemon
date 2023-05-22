import 'package:flutter/material.dart';

import '../../../widgets/build_text_field.dart';
import '../../../widgets/random_password.dart';

class AddUsers extends StatefulWidget {
  const AddUsers({
    super.key,
  });

  @override
  State<AddUsers> createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {
  final email = TextEditingController();
  final name = TextEditingController();
  final surname = TextEditingController();
  bool addUser = false;
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (addUser == false) {
      return Column(children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              addUser = true;
            });
          },
          child: const Text('Dodaj Użytkownika'),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Usuń Użytkownika'),
        ),
      ]);
    }
    return Column(children: [
      const Text('Dodawanie Użytkownika'),
      const SizedBox(
        height: 10,
      ),
      BuildTextField(
          hideText: false,
          hintText: 'Podaj imię swojego kursanta',
          controller: name),
      const SizedBox(
        height: 10,
      ),
      BuildTextField(
          hideText: false,
          hintText: 'Podaj nazwisko swojego kursanta',
          controller: surname),
      const SizedBox(
        height: 10,
      ),
      BuildTextField(
        hintText: 'Podaj E-mail Użytkownika',
        controller: email,
        hideText: false,
      ),
      const SizedBox(
        height: 10,
      ),
      BuildTextField(
          hideText: false,
          hintText: 'Tymczasowe hasło dla użytkownika',
          controller: password),
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: const Text('Utwórz Konto'),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
            onPressed: () {
              String randomPassword = generatePassword();
              password.text = randomPassword;
            },
            child: const Text('Generuj hasło'),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: IconButton(
          onPressed: () {
            setState(() {
              addUser = false;
            });
          },
          icon: const Icon(Icons.arrow_back),
        ),
      )
    ]);
  }
}
