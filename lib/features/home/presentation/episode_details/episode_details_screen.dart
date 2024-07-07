import 'package:flutter/material.dart';
import 'package:series_spot/features/home/domain/entities/episode_entity.dart';

class EpisodeDetailsScreen extends StatefulWidget {
  final EpisodeEntity episode;
  const EpisodeDetailsScreen({super.key, required this.episode});

  @override
  State<EpisodeDetailsScreen> createState() => _EpisodeDetailsScreenState();
}

class _EpisodeDetailsScreenState extends State<EpisodeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
