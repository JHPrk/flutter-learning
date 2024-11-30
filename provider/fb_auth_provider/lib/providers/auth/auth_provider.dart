import 'package:fb_auth_provider/providers/auth/auth_state.dart';
import 'package:fb_auth_provider/repositories/auth_repositories.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:logging/logging.dart';
import 'package:state_notifier/state_notifier.dart';

class AuthProvider extends StateNotifier<AuthState> with LocatorMixin {
  static final _log = Logger('AuthProvider');

  AuthProvider() : super(AuthState.unknown());

  @override
  void update(Locator watch) {
    final user = watch<fbAuth.User?>();
    if (user != null) {
      state = state.copyWith(authStatus: AuthStatus.authenticated, user: user);
    } else {
      state = state.copyWith(authStatus: AuthStatus.unauthenticated);
    }
    _log.fine('authState: $state');
    super.update(watch);
  }

  void signout() async {
    await read<AuthRepository>().signout();
  }
}
