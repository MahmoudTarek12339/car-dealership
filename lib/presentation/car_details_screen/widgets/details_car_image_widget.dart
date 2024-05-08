import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';

class DetailsCarImageWidget extends StatelessWidget {
  final String image;
  const DetailsCarImageWidget(this.image,{super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200.0,
      child: CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
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
