import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursdemo/features/user_console_navigator/panel_of_users/cubit/user_panel_cubit.dart';
import 'package:kursdemo/repository/repository.dart';

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
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserPanelCubit(Repository()),
      child: BlocBuilder<UserPanelCubit, UserPanelState>(
        builder: (context, state) {
          if (state.addUser) {
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
                    onPressed: () {
                      if (email.text.isNotEmpty &&
                          name.text.isNotEmpty &&
                          password.text.isNotEmpty &&
                          surname.text.isNotEmpty) {
                        context.read<UserPanelCubit>().addUser(
                            name: name.text,
                            surname: surname.text,
                            email: email.text,
                            pass: password.text);
                        email.clear();
                        password.clear();
                        name.clear();
                        surname.clear();
                        context.read<UserPanelCubit>().user(false);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                backgroundColor: Colors.black,
                                content: Text(
                                  'Musisz wypełnić wszystkie pola',
                                  style: TextStyle(color: Colors.white),
                                )));
                      }
                    },
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
                    context.read<UserPanelCubit>().user(false);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              )
            ]);
          }
          return Column(children: [
            ElevatedButton(
              onPressed: () {
                context.read<UserPanelCubit>().user(true);
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
        },
      ),
    );
  }
}
