import 'dart:async';

import 'package:application/application.dart';
import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AuthenticationHelperInterface authenticationHelperInterface,
    required User user,
  })  : _authHelper = authenticationHelperInterface,
        super(
          user == User.anonymous
              ? const AppState.unauthenticated()
              : AppState.authenticated(user),
        ) {
    on<AppUserChanged>(_onUserChanged);
    on<AppOnboardingCompleted>(_onOnboardingCompleted);
    on<AppLogoutRequested>(_onLogoutRequested);
    on<AppOpened>(_onAppOpened);

    _userSubscription = _authHelper.userStream.listen(_userChanged);
  }

  final AuthenticationHelperInterface _authHelper;

  late StreamSubscription<User> _userSubscription;

  void _userChanged(User user) => add(AppUserChanged(user));

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    final user = event.user;

    switch (state.status) {
      case AppStatus.onboardingRequired:
      case AppStatus.authenticated:
      case AppStatus.unauthenticated:
        return user != User.anonymous && user.isNewUser
            ? emit(AppState.onboardingRequired(user))
            : user == User.anonymous
                ? emit(const AppState.unauthenticated())
                : emit(AppState.authenticated(user));
    }
  }

  void _onOnboardingCompleted(
    AppOnboardingCompleted event,
    Emitter<AppState> emit,
  ) {
    if (state.status == AppStatus.onboardingRequired) {
      return state.user == User.anonymous
          ? emit(const AppState.unauthenticated())
          : emit(AppState.authenticated(state.user));
    }
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    // We are disabling notifications when a user logs out because
    // the user should not receive any notifications when logged out.
    //unawaited(_notificationsRepository.toggleNotifications(enable: false));

    unawaited(_authHelper.signOut());
  }

  Future<void> _onAppOpened(AppOpened event, Emitter<AppState> emit) async {
    if (state.user.isAnonymous) {}
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
