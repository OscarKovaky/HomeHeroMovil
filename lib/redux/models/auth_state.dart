class AuthState {
  final bool isLoggedIn;
  final bool isMfaCompleted;
  final String? token;

  AuthState({
    required this.isLoggedIn,
    required this.isMfaCompleted,
    this.token,
  });

  AuthState.initialState()
      : isLoggedIn = false,
        isMfaCompleted = false,
        token = null;
}
