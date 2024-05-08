import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_dealership/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

import '../../resources/assets_manager.dart';

class CarImageWidget extends StatelessWidget {
  final String image;

  const CarImageWidget(this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: double.infinity,
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
      ),
    ));
  }
}
