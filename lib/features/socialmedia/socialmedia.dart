import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kursdemo/features/socialmedia/cubit/social_cubit_cubit.dart';
import 'package:kursdemo/repository/repository.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubitCubit(Repository())..start(),
      child: BlocBuilder<SocialCubitCubit, SocialCubitState>(
        builder: (context, state) {
          final socials = state.socialmedia;
          return Card(
            shadowColor: Colors.black,
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                for (final oneSocial in socials)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (oneSocial.showFacebook == true)
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(FontAwesome.facebook)),
                      const SizedBox(
                        height: 20,
                      ),
                      if (oneSocial.showInstagram == true)
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(FontAwesome.instagram)),
                      const SizedBox(
                        height: 20,
                      ),
                      if (oneSocial.showTwitter == true)
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(FontAwesome.twitter)),
                      const SizedBox(
                        height: 20,
                      ),
                      if (oneSocial.showYouTube == true)
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(FontAwesome.youtube))
                    ],
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}

// IconButton(
//   onPressed: () {},
//   icon: const Icon(Icons.facebook),
// ),
// IconButton(
//   onPressed: () {},
//   icon: const Icon(Icons.youtube_searched_for),
// ),
// IconButton(
//     onPressed: () {},
//     icon: const Icon(Icons.transfer_within_a_station))
