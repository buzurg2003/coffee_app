import '../entities/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> loginWithEmailAndPassword(String email, String password);
  Future<AppUser?> registerWithEmailAndPassword(
      String name, String email, String password);
  Future<void> logout();
  Future<AppUser?> getCurrentUser();
  Future<String> sendPasswordResetEmail(String name);
  Future<void> deleteAccount();
  Future<AppUser?> signInWithGoogle();
  Future<AppUser?> signInWithApple();
}
