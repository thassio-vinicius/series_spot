import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:series_spot/core/injector.dart';
import 'package:series_spot/core/presentation/widgets/colored_safearea.dart';
import 'package:series_spot/core/presentation/widgets/fading_image_background.dart';
import 'package:series_spot/core/presentation/widgets/my_text.dart';
import 'package:series_spot/core/presentation/widgets/stack_back_arrow.dart';
import 'package:series_spot/core/utils/colors.dart';
import 'package:series_spot/features/home/domain/entities/episode_entity.dart';
import 'package:series_spot/l10n/global_app_localizations.dart';

class EpisodeDetailsScreen extends StatefulWidget {
  final EpisodeEntity episode;
  const EpisodeDetailsScreen({super.key, required this.episode});

  @override
  State<EpisodeDetailsScreen> createState() => _EpisodeDetailsScreenState();
}

class _EpisodeDetailsScreenState extends State<EpisodeDetailsScreen> {
  String? buildSmallHeader() {
    final intl = sl<GlobalAppLocalizations>().current;

    final season = intl.season(widget.episode.season);
    final number = widget.episode.number == null
        ? null
        : intl.episode(widget.episode.number!);
    final rate = widget.episode.rating?.average == null
        ? null
        : '⭐ ${widget.episode.rating!.average!}';

    final parts = [
      if (number != null) number,
      season,
      if (rate != null) rate,
    ];

    return parts.isNotEmpty ? parts.join(' | ') : null;
  }

  @override
  Widget build(BuildContext context) {
    final intl = sl<GlobalAppLocalizations>().current;

    return ColoredSafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            ListView(
              children: [
                FadingImageBackground(
                  image: widget.episode.image,
                  placeholderHeightPercentage: 0.3,
                  imageHeightPercentage: 0.3,
                  heroTag: widget.episode.id,
                ),
                MyText.large(
                  widget.episode.name,
                  style: MyTextStyle(
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 12),
                if (buildSmallHeader() != null) ...[
                  MyText(
                    buildSmallHeader()!,
                    style: MyTextStyle(
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                if (widget.episode.airDate != null)
                  MyText(
                    intl.airedOn(DateFormat.yMMMMd()
                        .format(DateTime.parse(widget.episode.airDate!))),
                    style: MyTextStyle(
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(height: 12),
                if (widget.episode.summary != null) ...[
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: HtmlWidget(
                      widget.episode.summary!,
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
              ],
            ),
            const StackBackArrow(),
          ],
        ),
      ),
    );
  }
}
