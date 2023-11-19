import 'package:app_ui/app_ui.dart';
import 'package:application_template/app/app.dart';
import 'package:application_template/app_lifecycle/app_lifecycle.dart';
import 'package:application_template/injection_container.dart';
import 'package:application_template/l10n/l10n.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppLifecycleObserver(
        child: BlocProvider(
            create: (context) => mainSl<AppBloc>(), child: const AppView()));
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: const AppTheme().themeData,
      darkTheme: const AppDarkTheme().themeData,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: AuthenticatedUserListener(
        child: FlowBuilder<AppStatus>(
          state: context.select((AppBloc bloc) => bloc.state.status),
          onGeneratePages: onGenerateAppViewPages,
        ),
      ),
    );
    ;
  }
}
