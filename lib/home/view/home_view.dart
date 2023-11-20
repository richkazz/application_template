import 'package:application_template/app/app.dart';
import 'package:application_template/home/home.dart';
import 'package:application_template/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab =
        context.select((HomeCubit cubit) => cubit.state.tabIndex);
    return MultiBlocListener(
      listeners: [
        BlocListener<AppBloc, AppState>(
          listenWhen: (previous, current) =>
              previous.showLoginOverlay != current.showLoginOverlay,
          listener: (context, state) {
            if (state.showLoginOverlay) {
              // showAppModal<void>(
              //   context: context,
              //   builder: (context) => const LoginModal(),
              //   routeSettings: const RouteSettings(name: LoginModal.name),
              // );
            }
          },
        ),
        BlocListener<HomeCubit, HomeState>(
          listener: (context, state) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
      ],
      child: Scaffold(
        body: IndexedStack(
          index: selectedTab,
          children: const [Login()],
        ),
      ),
    );
  }
}
