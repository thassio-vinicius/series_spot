import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:series_spot/core/utils/colors.dart';
import 'package:series_spot/features/home/domain/entities/image_entity.dart';

class FadingImageBackground extends StatelessWidget {
  final int heroTag;
  final ImageEntity? image;
  final double placeholderHeightPercentage;
  final double imageHeightPercentage;
  final BoxFit fit;

  const FadingImageBackground({
    required this.heroTag,
    required this.placeholderHeightPercentage,
    required this.imageHeightPercentage,
    this.fit = BoxFit.fitWidth,
    this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, Colors.transparent],
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
      },
      blendMode: BlendMode.dstIn,
      child: Hero(
        tag: heroTag,
        child: image == null
            ? SizedBox(
                height: MediaQuery.sizeOf(context).height *
                    placeholderHeightPercentage,
                child: Center(
                  child: Icon(
                    Icons.tv_off,
                    color: AppColors.containerBackground.withOpacity(0.55),
                    size: 52,
                  ),
                ),
              )
            : CachedNetworkImage(
                imageUrl: image!.original,
                progressIndicatorBuilder: (context, url, progress) => SizedBox(
                  height:
                      MediaQuery.sizeOf(context).height * imageHeightPercentage,
                ),
                errorWidget: (context, url, error) => SizedBox(
                  height:
                      MediaQuery.sizeOf(context).height * imageHeightPercentage,
                  child: Center(
                    child: Icon(
                      Icons.tv_off,
                      color: AppColors.containerBackground.withOpacity(0.55),
                      size: 52,
                    ),
                  ),
                ),
                width: MediaQuery.sizeOf(context).width,
                fit: fit,
              ),
      ),
    );
  }
}
