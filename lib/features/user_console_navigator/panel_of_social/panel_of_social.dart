import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursdemo/features/user_console_navigator/panel_of_social/cubit/panel_social_cubit.dart';
import 'package:kursdemo/repository/repository.dart';

class PanelSocialMedia extends StatelessWidget {
  const PanelSocialMedia({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PanelSocialCubit(Repository()),
      child: BlocBuilder<PanelSocialCubit, PanelSocialState>(
        builder: (context, state) {
          return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text('Dodawanie SocialMedia'),
            ElevatedButton(
                onPressed: () {
                  context.read<PanelSocialCubit>().addinstance(
                      showYouTube: true,
                      showFacebook: true,
                      showInstagram: true,
                      showTwitter: true,
                      youtubeLink: 'youtubeLink',
                      twitterLink: 'twitterLink',
                      instagramLink: 'instagramLink',
                      facebookLink: 'facebookLink');
                },
                child: const Text('Firebase'))
          ]);
        },
      ),
    );
  }
}
