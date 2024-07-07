import 'package:flutter/material.dart';
import 'package:series_spot/core/injector.dart';
import 'package:series_spot/core/presentation/widgets/my_text.dart';
import 'package:series_spot/features/home/domain/entities/show_entity.dart';
import 'package:series_spot/l10n/global_app_localizations.dart';

class TVShowHeaderRow extends StatelessWidget {
  final ShowEntity show;
  const TVShowHeaderRow({super.key, required this.show});

  String? showDuration() {
    if (show.premiered == null && show.ended == null) return null;
    if (show.premiered == null) {
      return DateTime.parse(show.ended!).year.toString();
    }
    if (show.ended == null) {
      return DateTime.parse(show.premiered!).year.toString();
    }
    return '${DateTime.parse(show.premiered!).year} - ${DateTime.parse(show.ended!).year}';
  }

  String? genres() {
    if (show.genres?.isEmpty ?? true) return null;
    String genres = '';

    for (String genre in show.genres!) {
      genres += genre == show.genres!.last ? genre : '$genre, ';
    }

    return genres;
  }

  String? rating() {
    if (show.rating?.average == null) return null;

    return '⭐ ${show.rating!.average!}';
  }

  String? airingTimes() {
    final intl = sl<GlobalAppLocalizations>().current;
    if (show.schedule == null) return null;

    String airingDays = '';

    for (String airingDay in show.schedule!.days) {
      airingDays +=
          airingDay == show.schedule!.days.last ? airingDay : '$airingDay, ';
    }

    return show.schedule?.time.isEmpty ?? true
        ? airingDays
        : intl.airingTimes(show.schedule!.time, airingDays);
  }

  String? buildSmallHeader() {
    if (showDuration() == null && rating() == null && genres() == null) {
      return null;
    }

    if (showDuration() == null) {
      return genres() == null ? rating() : '${genres()} | ${rating()}';
    } else if (genres() == null) {
      return rating() == null
          ? showDuration()
          : '${showDuration()} | ${rating()}';
    } else if (rating() == null) {
      return genres() == null
          ? showDuration()
          : '${showDuration()} | ${genres()}';
    }

    return '${showDuration()} | ${genres()} | ${rating()}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (buildSmallHeader() != null)
          MyText.small(
            buildSmallHeader()!,
            style: MyTextStyle(
              textAlign: TextAlign.center,
            ),
          ),
        if (airingTimes() != null) ...[
          MyText.small(
            airingTimes()!,
            style: MyTextStyle(
              textAlign: TextAlign.center,
            ),
          ),
        ]
      ],
    );
  }
}
