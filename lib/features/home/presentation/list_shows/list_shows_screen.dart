import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:series_spot/core/injector.dart';
import 'package:series_spot/core/presentation/widgets/blur_blackground.dart';
import 'package:series_spot/core/presentation/widgets/colored_safearea.dart';
import 'package:series_spot/core/presentation/widgets/my_text.dart';
import 'package:series_spot/core/utils/colors.dart';
import 'package:series_spot/features/home/presentation/list_shows/components/tv_show_card.dart';
import 'package:series_spot/features/home/presentation/list_shows/cubit/fetch_shows_cubit.dart';
import 'package:series_spot/l10n/global_app_localizations.dart';

class ListShowsScreen extends StatefulWidget {
  const ListShowsScreen({super.key});

  @override
  State<ListShowsScreen> createState() => _ListShowsScreenState();
}

class _ListShowsScreenState extends State<ListShowsScreen> {
  final TextEditingController _queryController = TextEditingController();

  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    final intl = sl<GlobalAppLocalizations>().current;
    return BlocProvider(
      create: (_) => ShowsCubit(sl())..fetchShows(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ColoredSafeArea(
          child: Scaffold(
            body: BlurBackground(
              child: Column(
                children: [
                  Builder(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 24.0,
                        right: 24.0,
                        top: 24.0,
                      ),
                      child: SearchBar(
                        leading: Icon(
                          Icons.search,
                          color:
                              AppColors.containerBackground.withOpacity(0.55),
                        ),
                        hintText: intl.searchHint,
                        controller: _queryController,
                        onChanged: (query) {
                          if (query.trim().length > 2) {
                            if (_debounce?.isActive ?? false) {
                              _debounce?.cancel();
                            }
                            _debounce =
                                Timer(const Duration(milliseconds: 1000), () {
                              if (_queryController.text.trim().length >= 3) {
                                context.read<ShowsCubit>().searchShows(query);
                              }
                            });
                          } else if (query.isEmpty) {
                            context.read<ShowsCubit>().fetchShows();
                          }
                        },
                        textStyle: MaterialStatePropertyAll(
                          GoogleFonts.poppins(color: Colors.white),
                        ),
                        hintStyle: MaterialStatePropertyAll(
                          GoogleFonts.poppins(
                              color: AppColors.containerBackground
                                  .withOpacity(0.55)),
                        ),
                        backgroundColor: const MaterialStatePropertyAll(
                          AppColors.background,
                        ),
                      ),
                    );
                  }),
                  Expanded(
                    child: BlocBuilder<ShowsCubit, ShowsState>(
                      builder: (context, state) {
                        if (state is ShowsLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.containerBackground,
                            ),
                          );
                        }

                        if (state is ShowsFailedState) {
                          return Center(
                            child: MyText(state.failure.message),
                          );
                        }

                        if (state is ShowsLoadedState ||
                            state is FetchNextPageState) {
                          return Column(
                            children: [
                              const SizedBox(height: 24),
                              Expanded(
                                flex: 15,
                                child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 16,
                                      childAspectRatio: 0.5,
                                    ),
                                    padding: const EdgeInsets.only(
                                      bottom: 24,
                                      left: 24,
                                      right: 24,
                                    ),
                                    itemCount: state.shows.length,
                                    itemBuilder: (context, index) {
                                      if (index == state.shows.length - 3 &&
                                          _queryController.text.isEmpty) {
                                        context
                                            .read<ShowsCubit>()
                                            .checkPagination();
                                      }

                                      return TVShowCard(
                                        show: state.shows[index],
                                      );
                                    }),
                              ),
                              if (state is FetchNextPageState) ...[
                                const Spacer(),
                                const Flexible(
                                  child: CircularProgressIndicator(
                                    color: AppColors.containerBackground,
                                  ),
                                ),
                              ]
                            ],
                          );
                        }

                        return Container();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
