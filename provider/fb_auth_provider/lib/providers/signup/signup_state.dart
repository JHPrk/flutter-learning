// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:fb_auth_provider/models/custom_error.dart';

enum SignupStatus {
  initial,
  submitting,
  success,
  error,
}

class SignupState extends Equatable {
  final SignupStatus signupStatus;
  final CustomError e;
  SignupState({
    required this.signupStatus,
    required this.e,
  });

  factory SignupState.initial() {
    return SignupState(
      signupStatus: SignupStatus.initial,
      e: CustomError(),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [signupStatus, e];

  SignupState copyWith({
    SignupStatus? signupStatus,
    CustomError? e,
  }) {
    return SignupState(
      signupStatus: signupStatus ?? this.signupStatus,
      e: e ?? this.e,
    );
  }
}
