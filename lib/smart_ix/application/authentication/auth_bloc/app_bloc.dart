import 'dart:async';

import 'package:smart_ix/smart_ix/application/application.dart';

part 'app_event.dart';
part 'app_state.dart';

/// the AppBloc is responsible for listening to the firebase auth for new auth state.
/// the AuthenticationRepository.
/// subscribe to a stream of user, to notify whenever the auth state changes

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(authenticationRepository.currentUser.isNotEmpty
            ? AppState.authenticated(authenticationRepository.currentUser)
            : const AppState.unauthenticated()) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequest>(_onLogoutRequest);

    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(
        AppUserChanged(user),
      ),
    );
  }

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    emit(
      event.user.isNotEmpty
          ? AppState.authenticated(event.user)
          : const AppState.unauthenticated(),
    );
  }

  void _onLogoutRequest(AppLogoutRequest event, Emitter<AppState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  /// cancel stream subscription
  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
