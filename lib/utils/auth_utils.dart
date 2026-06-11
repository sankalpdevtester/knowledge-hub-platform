import 'package:comprehensive_knowledge_hub_platform/services/auth_service.dart';

class AuthUtils {
  final AuthService _authService = AuthService();

  Future<void> handleSignInWithGoogle() async {
    final User? user = await _authService.signInWithGoogle();
    if (user != null) {
      await _authService.createUserProfile(user);
    }
  }

  Future<void> handleSignOut() async {
    await _authService.signOut();
  }

  Stream<User?> getUserStream() {
    return _authService.userStream;
  }
}