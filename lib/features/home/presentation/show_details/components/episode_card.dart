import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:series_spot/core/presentation/routes/my_navigator.dart';
import 'package:series_spot/core/presentation/routes/route_names.dart';
import 'package:series_spot/core/presentation/widgets/my_text.dart';
import 'package:series_spot/features/home/domain/entities/episode_entity.dart';
import 'package:series_spot/features/home/presentation/show_details/components/fading_image_background.dart';

class EpisodeCard extends StatelessWidget {
  final EpisodeEntity episode;
  const EpisodeCard({required this.episode, super.key});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16);
    return GestureDetector(
      onTap: () => MyNavigator(context).pushNamed(
        RouteNames.episodeDetails,
        extra: episode,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.35,
            height: MediaQuery.sizeOf(context).height * 0.25,
            child: ClipRRect(
              borderRadius: borderRadius,
              child: FadingImageBackground(
                heroTag: episode.id,
                placeholderHeightPercentage: 0.25,
                imageHeightPercentage: 0.25,
                image: episode.image,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Positioned(
            bottom: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.1,
                child: FittedBox(
                  alignment: Alignment.bottomCenter,
                  fit: BoxFit.scaleDown,
                  child: MyText.small(
                    (episode.number != null ? '${episode.number} - ' : '') +
                        episode.name,
                    style: MyTextStyle(
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
