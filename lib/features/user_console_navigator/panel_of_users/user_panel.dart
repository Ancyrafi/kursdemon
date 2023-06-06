import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursdemo/features/user_console_navigator/panel_of_users/cubit/user_panel_cubit.dart';
import 'package:kursdemo/repository/repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
      create: (context) => UserPanelCubit(Repository())..start(),
      child: BlocBuilder<UserPanelCubit, UserPanelState>(
        builder: (context, state) {
          final users = state.users;
          if (state.addUser) {
            return Column(children: [
              Text(AppLocalizations.of(context)!.addUserInfo),
              const SizedBox(
                height: 10,
              ),
              BuildTextField(
                  enabled: true,
                  hideText: false,
                  hintText: AppLocalizations.of(context)!.addUserName,
                  controller: name),
              const SizedBox(
                height: 10,
              ),
              BuildTextField(
                  enabled: true,
                  hideText: false,
                  hintText: AppLocalizations.of(context)!.addUserSurrname,
                  controller: surname),
              const SizedBox(
                height: 10,
              ),
              BuildTextField(
                enabled: true,
                hintText: AppLocalizations.of(context)!.addUserEmail,
                controller: email,
                hideText: false,
              ),
              const SizedBox(
                height: 10,
              ),
              BuildTextField(
                  enabled: true,
                  hideText: false,
                  hintText: AppLocalizations.of(context)!.addUserPassword,
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
                        try {
                          context.read<UserPanelCubit>().addUser(
                              name: name.text,
                              surname: surname.text,
                              email: email.text,
                              pass: password.text);
                          context.read<UserPanelCubit>().user(false);
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                error.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.black,
                            ),
                          );
                        }

                        email.clear();
                        password.clear();
                        name.clear();
                        surname.clear();
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
                    child: Text(AppLocalizations.of(context)!.addUserButton),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      String randomPassword = generatePassword();
                      password.text = randomPassword;
                    },
                    child: Text(
                        AppLocalizations.of(context)!.addUserPassGenButton),
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
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 44, 65, 83),
              borderRadius: BorderRadius.circular(50),
            ),
            margin: const EdgeInsets.all(30),
            padding: const EdgeInsets.all(30),
            child: ListView(children: [
              for (final user in users)
                ExpansionTile(
                  textColor: Colors.black,
                  childrenPadding: EdgeInsets.zero,
                  expandedAlignment: Alignment.center,
                  expandedCrossAxisAlignment: CrossAxisAlignment.center,
                  tilePadding: EdgeInsets.zero,
                  iconColor: Colors.black,
                  title: Center(
                    child: Text('${user.name} ${user.surname}'),
                  ),
                  children: [
                    ListTile(
                      title: Text('E-mail: ${user.email}'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      title: Text('Password: ${user.pass}'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        try {
                          context.read<UserPanelCubit>().deleteUser(
                              userID: user.userID,
                              documentID: user.documentID,
                              email: user.email,
                              pass: user.pass);
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.black,
                              content: Text(
                                error.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(AppLocalizations.of(context)!.deleteButtton),
                    ),
                  ],
                ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {
                    context.read<UserPanelCubit>().user(true);
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            ]),
          );
        },
      ),
    );
  }
}
