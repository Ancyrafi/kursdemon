import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursdemo/features/authgate/cubit/auth_cubit.dart';
import 'package:kursdemo/features/home/home.dart';
import 'package:kursdemo/features/home_user/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kursdemo/repository/repository.dart';
import 'package:kursdemo/widgets/build_text_field.dart';

class AuthGate extends StatelessWidget {
  AuthGate({super.key});

  final email = TextEditingController();
  final pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(Repository())..start(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final user = state.user;
          if (user == null) {
            return Scaffold(
              body: Center(
                child: Card(
                  color: Colors.blue,
                  shadowColor: Colors.black,
                  margin: const EdgeInsets.all(20),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BuildTextField(
                            enabled: true,
                            hideText: false,
                            hintText: 'E - mail...',
                            controller: email),
                        const SizedBox(
                          height: 10,
                        ),
                        BuildTextField(
                            enabled: true,
                            hideText: true,
                            hintText: AppLocalizations.of(context)!.password,
                            controller: pass),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          onPressed: () {
                            context
                                .read<AuthCubit>()
                                .logIn(email: email.text, pass: pass.text);
                          },
                          child: Text(AppLocalizations.of(context)!.loginButton),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          if (user.email == 'siudy@dev.pl') {
            return HomePage();
          }
          return HomePageUser();
        },
      ),
    );
  }
}
