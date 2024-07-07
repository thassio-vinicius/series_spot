import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:series_spot/core/presentation/routes/my_navigator.dart';
import 'package:series_spot/core/presentation/widgets/blur_blackground.dart';
import 'package:series_spot/core/presentation/widgets/colored_safearea.dart';
import 'package:series_spot/core/presentation/widgets/my_text.dart';
import 'package:series_spot/core/utils/colors.dart';
import 'package:series_spot/features/home/domain/entities/show_entity.dart';
import 'package:series_spot/features/home/presentation/components/fading_image_background.dart';
import 'package:series_spot/features/home/presentation/components/tv_show_header_row.dart';

class TVShowDetailsScreen extends StatefulWidget {
  final ShowEntity show;
  const TVShowDetailsScreen({super.key, required this.show});

  @override
  State<TVShowDetailsScreen> createState() => _TVShowDetailsScreenState();
}

class _TVShowDetailsScreenState extends State<TVShowDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return ColoredSafeArea(
      child: Scaffold(
        body: BlurBackground(
          child: Stack(
            children: [
              ListView(
                children: [
                  FadingImageBackground(widget.show),
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
                ],
              ),
              Positioned(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
