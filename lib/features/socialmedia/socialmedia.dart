import 'package:flutter/material.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.facebook),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.youtube_searched_for),
        ),
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.transfer_within_a_station))
      ],
    );
  }
}
