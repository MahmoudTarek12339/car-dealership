import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_dealership/presentation/resources/constants.dart';
import 'package:flutter/material.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';

class DetailsCarImageWidget extends StatelessWidget {
  final String image;

  const DetailsCarImageWidget(this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return AspectRatio(
      //here to make car item responsive between mobile and tablet
      aspectRatio: width < AppConstants.kTabletBreakPoint ? 1.75 : 2.00,
      child: CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.fitWidth,
        progressIndicatorBuilder: (context, url, progress) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorManager.green,
              value: progress.progress,
            ),
          );
        },
        errorWidget: (context, _, __) {
          return Image.asset(
            ImageAssets.splash,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
