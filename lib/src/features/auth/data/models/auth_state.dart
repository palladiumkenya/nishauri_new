import 'package:nishauri/src/features/user/data/models/user.dart';

class AuthState {
  final bool isAuthenticated;
  final bool isAccountVerified;
  final bool isProfileComplete;

  AuthState({
    required this.isAccountVerified,
    required this.isProfileComplete,
    required this.isAuthenticated,
  });

  factory AuthState.defaultState() {
    return AuthState(
      isAccountVerified: false  ,
      isProfileComplete: false,
      isAuthenticated: false
    );
  }

  factory AuthState.fromResponse({
    bool isAccountVerified = false,
    bool isProfileComplete = false,
    bool isAuthenticated = false
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated,
      isAccountVerified: isAccountVerified,
      isProfileComplete: isProfileComplete,
    );
  }

  AuthState copyWith({

    bool? isAccountVerified,
    bool? isAuthenticated,
    bool? isProfileComplete,
  }) =>
      AuthState(
        isAuthenticated: isAuthenticated ?? this.isAuthenticated,
        isAccountVerified: isAccountVerified ?? this.isAccountVerified,
        isProfileComplete: isProfileComplete ?? this.isProfileComplete,
      );

  @override
  String toString() {
    return "AuthState<isAuthenticated: $isAuthenticated, isAccountVerified: $isAccountVerified, isProfileComplete: $isProfileComplete>";
  }
}


class AuthResponse{
  final String? accessToken;
  final String? refreshToken;
  final bool accountVerified;
  final bool profileUpdated;
  final String? userId;
  final String? message;
  final String? phoneNumber;

  AuthResponse({ required this.accountVerified, required this.profileUpdated, this.accessToken, this.refreshToken,  this.userId,  this.message, this.phoneNumber});
  @override
  String toString() {
    return "AuthState<accessToken: $accessToken, refreshToken: $refreshToken, accountVerified: $accountVerified, profileUpdated: $profileUpdated, userId: $userId, message: $message, phoneNumber: $phoneNumber>";
  }
}
