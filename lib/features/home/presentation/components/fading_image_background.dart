import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:series_spot/core/utils/colors.dart';
import 'package:series_spot/features/home/domain/entities/show_entity.dart';

class FadingImageBackground extends StatelessWidget {
  final ShowEntity show;
  const FadingImageBackground(this.show, {super.key});

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
        tag: show.id,
        child: show.image == null
            ? SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.5,
                child: Center(
                  child: Icon(
                    Icons.tv_off,
                    color: AppColors.containerBackground.withOpacity(0.55),
                    size: 52,
                  ),
                ),
              )
            : CachedNetworkImage(
                imageUrl: show.image!.original,
                progressIndicatorBuilder: (context, url, progress) => SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.7,
                ),
                errorWidget: (context, url, error) => SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.7,
                  child: Center(
                    child: Icon(
                      Icons.tv_off,
                      color: AppColors.containerBackground.withOpacity(0.55),
                      size: 52,
                    ),
                  ),
                ),
                width: MediaQuery.sizeOf(context).width,
                fit: BoxFit.fitWidth,
              ),
      ),
    );
  }
}
