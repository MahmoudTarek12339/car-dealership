import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //user profile picture
    return const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 5.0,
        ),
        child: CircleAvatar(
          radius: 14,
          backgroundImage: CachedNetworkImageProvider(
              'https://i.pinimg.com/originals/3c/59/da/3c59da5f6aefd35919550e9405dc63c4.jpg'),
        ),
      );
  }
}
