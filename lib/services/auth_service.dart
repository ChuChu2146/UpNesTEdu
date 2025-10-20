class AuthService {
  AuthService._privateConstructor();

  static final AuthService instance = AuthService._privateConstructor();

  String? _currentRole;

  bool get isLoggedIn => _currentRole != null;
  String? get currentRole => _currentRole;

  Future<bool> login(
      {required String email,
      required String password,
      required String role}) async {
    // Mock login delay
    await Future.delayed(const Duration(milliseconds: 300));
    // Very simple mock: accept any non-empty email/password
    if (email.isNotEmpty && password.isNotEmpty) {
      _currentRole = role;
      return true;
    }
    return false;
  }

  void logout() {
    _currentRole = null;
  }
}
