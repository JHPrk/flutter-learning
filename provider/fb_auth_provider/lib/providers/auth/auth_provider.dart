import 'package:fb_auth_provider/providers/auth/auth_state.dart';
import 'package:fb_auth_provider/repositories/auth_repositories.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:logging/logging.dart';

class AuthProvider with ChangeNotifier {
  AuthState _state = AuthState.unknown();
  AuthState get state => _state;
  static final _log = Logger('AuthProvider');

  final AuthRepository authRepository;

  AuthProvider({required this.authRepository});

  void update(fbAuth.User? user) {
    if (user != null) {
      _state =
          _state.copyWith(authStatus: AuthStatus.authenticated, user: user);
    } else {
      _state = _state.copyWith(authStatus: AuthStatus.unauthenticated);
    }
    _log.fine('authState: $state');
    notifyListeners();
  }

  void signout() async {
    await authRepository.signout();
  }
}
