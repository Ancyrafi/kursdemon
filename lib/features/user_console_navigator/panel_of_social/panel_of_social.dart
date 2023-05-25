import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kursdemo/features/user_console_navigator/panel_of_social/cubit/panel_social_cubit.dart';

import 'package:kursdemo/repository/repository.dart';

class PanelSocialMedia extends StatelessWidget {
  const PanelSocialMedia({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PanelSocialCubit(Repository())..start(),
      child: BlocBuilder<PanelSocialCubit, PanelSocialState>(
        builder: (context, state) {
          final social = state.socialmedia;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state.check == true)
                ElevatedButton(
                    onPressed: () {
                      context.read<PanelSocialCubit>().addinstance(
                          createSocial: true,
                          showYouTube: false,
                          showFacebook: false,
                          showInstagram: false,
                          showTwitter: false,
                          youtubeLink: 'youtubeLink',
                          twitterLink: 'twitterLink',
                          instagramLink: 'instagramLink',
                          facebookLink: 'facebookLink');
                    },
                    child: const Text('Rozpocznij')),
              for (final oneSocial in social)
                if (oneSocial.createSocial)
                  Card(
                    margin: const EdgeInsets.all(20),
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ExpansionTile(
                            title: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Facebook'),
                                SizedBox(
                                  height: 10,
                                ),
                                Icon(FontAwesome.facebook),
                              ],
                            ),
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 300,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText: oneSocial.facebookLink,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Zapisz'),
                                  ),
                                  Switch(
                                      value: oneSocial.showFacebook,
                                      onChanged: (value) {
                                        context
                                            .read<PanelSocialCubit>()
                                            .showFacebok(
                                                showFB: value,
                                                socialID: oneSocial.socialID);
                                      })
                                ],
                              ),
                            ],
                          ),
                          //nowy title
                          ExpansionTile(
                            title: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Instagram'),
                                SizedBox(
                                  height: 10,
                                ),
                                Icon(FontAwesome.instagram),
                              ],
                            ),
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 300,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText: oneSocial.instagramLink,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Zapisz'),
                                  ),
                                  Switch(
                                      value: oneSocial.showInstagram,
                                      onChanged: (value) {
                                        context
                                            .read<PanelSocialCubit>()
                                            .showInstagram(
                                                showInsta: value,
                                                socialID: oneSocial.socialID);
                                      })
                                ],
                              ),
                            ],
                          ),
                          ExpansionTile(
                            title: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('YouTube'),
                                SizedBox(
                                  height: 10,
                                ),
                                Icon(FontAwesome.youtube_play),
                              ],
                            ),
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 300,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText: oneSocial.youtubeLink,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Zapisz'),
                                  ),
                                  Switch(
                                      value: oneSocial.showYouTube,
                                      onChanged: (value) {
                                        context
                                            .read<PanelSocialCubit>()
                                            .showYouTube(
                                                showYT: value,
                                                socialID: oneSocial.socialID);
                                      })
                                ],
                              ),
                            ],
                          ),
                          ExpansionTile(
                            title: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Twitter'),
                                SizedBox(
                                  height: 10,
                                ),
                                Icon(FontAwesome.twitter),
                              ],
                            ),
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 300,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText: oneSocial.facebookLink,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Zapisz'),
                                  ),
                                  Switch(
                                      value: oneSocial.showTwitter,
                                      onChanged: (value) {
                                        context
                                            .read<PanelSocialCubit>()
                                            .showTwitter(
                                                showTwit: value,
                                                socialID: oneSocial.socialID);
                                      })
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
            ],
          );
        },
      ),
    );
  }
}
