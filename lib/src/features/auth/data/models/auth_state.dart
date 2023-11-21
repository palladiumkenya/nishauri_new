import 'package:nishauri/src/features/user/data/models/user.dart';

class AuthState {
  final String token;
  final User? user;
  final bool isAccountVerified;
  final bool isProfileComplete;

  AuthState({
    this.token = "",
    this.user,
    this.isAccountVerified = false,
    this.isProfileComplete = false,
  });

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
