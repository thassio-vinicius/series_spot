import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:series_spot/core/presentation/routes/my_navigator.dart';
import 'package:series_spot/core/presentation/routes/route_names.dart';
import 'package:series_spot/core/presentation/widgets/my_text.dart';
import 'package:series_spot/core/utils/colors.dart';
import 'package:series_spot/features/home/domain/entities/show_entity.dart';

class TVShowCard extends StatelessWidget {
  final ShowEntity show;
  const TVShowCard({required this.show, super.key});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16);
    return GestureDetector(
      onTap: () => MyNavigator(context).pushNamed(
        RouteNames.tvShowDetails,
        extra: show,
      ),
      child: Column(
        children: [
          Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: borderRadius,
                  child: Hero(
                    tag: show.id,
                    child: show.image == null
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: borderRadius,
                              border: Border.all(
                                width: 1.5,
                                color: AppColors.containerBackground
                                    .withOpacity(0.55),
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.tv_off,
                                color: AppColors.containerBackground
                                    .withOpacity(0.55),
                                size: 36,
                              ),
                            ),
                          )
                        : CachedNetworkImage(imageUrl: show.image!.medium),
                  ),
                ),
              )),
          const SizedBox(height: 8),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: !show.name.contains(' ')
                  ? FittedBox(
                      alignment: Alignment.topCenter,
                      fit: BoxFit.scaleDown,
                      child: MyText.mediumSmall(
                        show.name,
                        style: MyTextStyle(
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : MyText.mediumSmall(
                      show.name,
                      overflow: TextOverflow.visible,
                      maxLines: 3,
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
