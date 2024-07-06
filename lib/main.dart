import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:series_spot/core/injector.dart' as di;
import 'package:series_spot/core/injector.dart';
import 'package:series_spot/core/presentation/routes/routes.dart';
import 'package:series_spot/l10n/global_app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  await di.init();

  runApp(const SeriesSpot());
}

class SeriesSpot extends StatelessWidget {
  const SeriesSpot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        sl<GlobalAppLocalizations>().setAppLocalizations(
          AppLocalizations.of(context),
        );
        return child ?? Container();
      },
    );
  }
}
