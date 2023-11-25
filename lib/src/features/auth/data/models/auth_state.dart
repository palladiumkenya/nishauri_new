import 'dart:ffi';

import 'package:nishauri/src/features/user/data/models/user.dart';

class AuthState {
  final String token;
  final User? user;
  final bool isAccountVerified;
  final bool isProfileComplete;

  AuthState({
    required this.token,
    required this.user,
    required this.isAccountVerified,
    required this.isProfileComplete,
  });

  factory AuthState.defaultState() {
    return AuthState(
      token: "",
      user: null,
      isAccountVerified: true,
      isProfileComplete: true,
    );
  }

  factory AuthState.fromResponse({
    String token = "",
    User? user,
    bool isAccountVerified = false,
    bool isProfileComplete = false,
  }) {
    return AuthState(
      token: token,
      user: user,
      isAccountVerified: isAccountVerified,
      isProfileComplete: isProfileComplete,
    );
  }

  AuthState copyWith({
    String? token,
    User? user,
    bool? isAccountVerified,
    bool? isProfileComplete,
  }) =>
      AuthState(
        token: token ?? this.token,
        user: user ?? this.user,
        isAccountVerified: isAccountVerified ?? this.isAccountVerified,
        isProfileComplete: isProfileComplete ?? this.isProfileComplete,
      );
}
