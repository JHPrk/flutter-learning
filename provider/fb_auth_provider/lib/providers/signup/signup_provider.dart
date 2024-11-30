import 'package:fb_auth_provider/models/custom_error.dart';
import 'package:fb_auth_provider/providers/signup/signup_state.dart';
import 'package:fb_auth_provider/repositories/auth_repositories.dart';
import 'package:state_notifier/state_notifier.dart';

class SignupProvider extends StateNotifier<SignupState> with LocatorMixin {
  SignupProvider() : super(SignupState.initial());

  Future<void> signup(
      {required String name,
      required String email,
      required String password}) async {
    state = state.copyWith(signupStatus: SignupStatus.submitting);

    try {
      await read<AuthRepository>()
          .signup(name: name, email: email, password: password);
      state = state.copyWith(signupStatus: SignupStatus.success);
    } on CustomError catch (e) {
      state = state.copyWith(signupStatus: SignupStatus.error, e: e);
      rethrow;
    }
  }
}
