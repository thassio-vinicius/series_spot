import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:series_spot/core/injector.dart';
import 'package:series_spot/core/presentation/routes/my_navigator.dart';
import 'package:series_spot/core/presentation/widgets/blur_blackground.dart';
import 'package:series_spot/core/presentation/widgets/colored_safearea.dart';
import 'package:series_spot/core/presentation/widgets/my_text.dart';
import 'package:series_spot/core/utils/colors.dart';
import 'package:series_spot/features/home/domain/entities/show_entity.dart';
import 'package:series_spot/features/home/presentation/show_details/components/episode_card.dart';
import 'package:series_spot/features/home/presentation/show_details/components/fading_image_background.dart';
import 'package:series_spot/features/home/presentation/show_details/components/tv_show_header_row.dart';
import 'package:series_spot/features/home/presentation/show_details/cubit/fetch_episodes_cubit.dart';
import 'package:series_spot/l10n/global_app_localizations.dart';

class TVShowDetailsScreen extends StatefulWidget {
  final ShowEntity show;
  const TVShowDetailsScreen({super.key, required this.show});

  @override
  State<TVShowDetailsScreen> createState() => _TVShowDetailsScreenState();
}

class _TVShowDetailsScreenState extends State<TVShowDetailsScreen> {
  Positioned _backArrow() {
    return Positioned(
      top: 4,
      left: 4,
      child: IconButton(
        onPressed: () => MyNavigator(context).pop(),
        icon: Container(
          decoration: BoxDecoration(
            color: AppColors.containerBackground.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(4),
          width: 36,
          height: 36,
          child: Icon(
            Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final intl = sl<GlobalAppLocalizations>().current;

    return ColoredSafeArea(
      child: Scaffold(
        body: BlurBackground(
          child: Stack(
            children: [
              ListView(
                children: [
                  FadingImageBackground(
                    image: widget.show.image,
                    placeholderHeightPercentage: 0.5,
                    imageHeightPercentage: 0.7,
                    heroTag: widget.show.id,
                  ),
                  MyText.xLarge(
                    widget.show.name,
                    style: MyTextStyle(
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TVShowHeaderRow(show: widget.show),
                  if (widget.show.summary != null) ...[
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: HtmlWidget(
                        widget.show.summary!,
                        customStylesBuilder: (map) => {'text-align': 'center'},
                        textStyle: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  BlocProvider(
                    create: (_) =>
                        EpisodesCubit(sl())..fetchEpisodes(widget.show.id),
                    child: BlocBuilder<EpisodesCubit, EpisodesState>(
                      builder: (context, state) {
                        if (state is EpisodesLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        }

                        if (state is EpisodesFailedState) {
                          return Center(
                            child: MyText(
                              state.failure.message,
                              style: MyTextStyle(textAlign: TextAlign.center),
                            ),
                          );
                        }

                        if (state is EpisodesLoadedState) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 24.0),
                                child: MyText.mediumSmall(
                                  intl.episodes,
                                  style:
                                      MyTextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.25,
                                child: ListView.builder(
                                  padding: EdgeInsets.symmetric(horizontal: 24),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.episodes.length,
                                  itemBuilder: (context, index) => Padding(
                                    padding: EdgeInsets.only(
                                      right: index == state.episodes.length - 1
                                          ? 0
                                          : 16.0,
                                    ),
                                    child: EpisodeCard(
                                      episode: state.episodes[index],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        }

                        return Container();
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
              _backArrow(),
            ],
          ),
        ),
      ),
    );
  }
}
