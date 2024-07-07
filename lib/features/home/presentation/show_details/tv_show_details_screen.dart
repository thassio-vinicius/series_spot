import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:series_spot/core/injector.dart';
import 'package:series_spot/core/presentation/widgets/blur_blackground.dart';
import 'package:series_spot/core/presentation/widgets/colored_safearea.dart';
import 'package:series_spot/core/presentation/widgets/fading_image_background.dart';
import 'package:series_spot/core/presentation/widgets/my_text.dart';
import 'package:series_spot/core/presentation/widgets/stack_back_arrow.dart';
import 'package:series_spot/core/utils/colors.dart';
import 'package:series_spot/features/home/domain/entities/show_entity.dart';
import 'package:series_spot/features/home/presentation/show_details/components/episode_card.dart';
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
  int? _selectedSeason;
  final _episodesController = ScrollController();

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
                    child: BlocConsumer<EpisodesCubit, EpisodesState>(
                      listener: (context, state) {
                        if (state is EpisodesLoadedState) {
                          _selectedSeason = state.episodes.first.season;
                        }
                      },
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
                          final seasonedEpisodes = state.episodes
                              .where((element) =>
                                  element.season ==
                                  (_selectedSeason ??
                                      state.episodes.first.season))
                              .toList();

                          final uniqueSeasons = <int>{};

                          for (var episode in state.episodes) {
                            uniqueSeasons.add(episode.season);
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 24.0),
                                child: MyText.medium(
                                  intl.episodes,
                                  style: MyTextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.only(left: 24.0),
                                child: DropdownButton<int>(
                                    value: _selectedSeason,
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    dropdownColor: AppColors.dropdownBackground,
                                    underline: Container(),
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white,
                                    ),
                                    items: List.generate(
                                      uniqueSeasons.length,
                                      (index) => DropdownMenuItem(
                                        value: uniqueSeasons.elementAt(index),
                                        child: MyText(
                                          intl.season(
                                              uniqueSeasons.elementAt(index)),
                                          style: MyTextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onChanged: (season) {
                                      setState(() {
                                        _selectedSeason = season;
                                        _episodesController.animateTo(
                                          0,
                                          duration: kThemeAnimationDuration,
                                          curve: Curves.easeIn,
                                        );
                                      });
                                    }),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.25,
                                child: ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: seasonedEpisodes.length,
                                  controller: _episodesController,
                                  itemBuilder: (context, index) => Padding(
                                    padding: EdgeInsets.only(
                                      right:
                                          index == seasonedEpisodes.length - 1
                                              ? 0
                                              : 16.0,
                                    ),
                                    child: EpisodeCard(
                                      episode: seasonedEpisodes[index],
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
              const StackBackArrow(),
            ],
          ),
        ),
      ),
    );
  }
}
