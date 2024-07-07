import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:series_spot/core/presentation/routes/my_navigator.dart';
import 'package:series_spot/core/presentation/routes/route_names.dart';
import 'package:series_spot/core/presentation/widgets/my_text.dart';
import 'package:series_spot/core/utils/colors.dart';
import 'package:series_spot/features/home/domain/entities/episode_entity.dart';

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
              child: Hero(
                tag: episode.id,
                child: episode.image == null
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: borderRadius,
                          border: Border.all(
                            width: 1.5,
                            color:
                                AppColors.containerBackground.withOpacity(0.55),
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.tv_off,
                            color:
                                AppColors.containerBackground.withOpacity(0.55),
                            size: 36,
                          ),
                        ),
                      )
                    : CachedNetworkImage(
                        imageUrl: episode.image!.original,
                        fit: BoxFit.fitHeight,
                      ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.35,
              height: MediaQuery.sizeOf(context).height * 0.25,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 6,
            left: 12,
            right: 12,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: MediaQuery.sizeOf(context).height * 0.1,
              child: MyText.small(
                (episode.number != null ? '${episode.number} - ' : '') +
                    episode.name,
                style: MyTextStyle(
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
