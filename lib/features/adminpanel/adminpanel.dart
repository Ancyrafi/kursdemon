import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursdemo/features/adminpanel/cubit/admin_cubit.dart';
import 'package:kursdemo/repository/repository.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    final title = TextEditingController();
    final subtitle = TextEditingController();
    final link = TextEditingController();
    return BlocProvider(
      create: (context) => AdminCubit(Repository()),
      child: BlocListener<AdminCubit, AdminState>(
        listener: (context, state) {
          if (state.save == true) {
            Navigator.of(context).pop();
          }
          if (state.errormsg.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errormsg),
                backgroundColor: Colors.black,
              ),
            );
          }
        },
        child: BlocBuilder<AdminCubit, AdminState>(
          builder: (context, state) {
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: title,
                    decoration: const InputDecoration(hintText: 'Nazwa'),
                  ),
                  TextField(
                    controller: subtitle,
                    decoration: const InputDecoration(hintText: 'podlekcja'),
                  ),
                  TextField(
                    controller: link,
                    decoration: const InputDecoration(hintText: 'link'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AdminCubit>().createLesson(
                          lessonTitle: title.text,
                          sublessonTitle: subtitle.text,
                          videoLink: link.text);
                    },
                    child: const Text('Dodaj'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
