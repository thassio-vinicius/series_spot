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
    final premieredYear = show.premiered != null
        ? DateTime.parse(show.premiered!).year.toString()
        : null;
    final endedYear =
        show.ended != null ? DateTime.parse(show.ended!).year.toString() : null;
    if (premieredYear == null) return endedYear;
    if (endedYear == null) return premieredYear;
    return '$premieredYear - $endedYear';
  }

  String? genres() {
    if (show.genres?.isEmpty ?? true) return null;
    return show.genres!.join(', ');
  }

  String? rating() {
    return show.rating?.average != null ? '⭐ ${show.rating!.average!}' : null;
  }

  String? airingTimes() {
    final intl = sl<GlobalAppLocalizations>().current;
    if (show.schedule == null) return null;
    final airingDays = show.schedule!.days.join(', ');
    return show.schedule?.time.isNotEmpty ?? false
        ? intl.airingTimes(show.schedule!.time, airingDays)
        : airingDays;
  }

  String? buildSmallHeader() {
    final duration = showDuration();
    final genre = genres();
    final rate = rating();

    final parts = [
      if (duration != null) duration,
      if (genre != null) genre,
      if (rate != null) rate,
    ];

    return parts.isNotEmpty ? parts.join(' | ') : null;
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
        if (airingTimes() != null)
          MyText.small(
            airingTimes()!,
            style: MyTextStyle(
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}
