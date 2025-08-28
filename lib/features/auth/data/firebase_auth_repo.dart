import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../domain/entities/app_user.dart';
import '../domain/repos/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  // ! access to firebase
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // ! LOGIN: Email & Password
  @override
  Future<AppUser?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      // attempt sign in
      final UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // create app user
      final user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
      );
      return user;
    }

    // catch any errors...
    catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  // ! REGISTER: Email & Password
  @override
  Future<AppUser?> registerWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      // attempt sign up
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // create app user
      final user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
      );
      return user;
    }

    // any errors...
    catch (e) {
      throw Exception("Registration failed: $e");
    }
  }

  //! DELETE ACCOUNT
  @override
  Future<void> deleteAccount() async {
    try {
      // get current user
      final user = firebaseAuth.currentUser;

      // check if user is logged in
      if (user == null) throw Exception("No user logged in..");

      // delete account
      await user.delete();

      // logout
      await logout();
    } catch (e) {
      throw Exception("Failed to delete account: $e");
    }
  }

  // ! GET CURRENT USER
  @override
  Future<AppUser?> getCurrentUser() async {
    // get current logged in user from firebase
    final firebaseUser = firebaseAuth.currentUser;
    // no logged in user
    if (firebaseUser == null) return null;

    // logged in user exist
    return AppUser(
      uid: firebaseUser.uid,
      email: firebaseUser.email!,
    );
  }

  // ! LOGOUT
  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  // ! RESET PASSWORD
  @override
  Future<String> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return "Password reset email sent! Check your inbox.";
    } catch (e) {
      return "An error occurred: $e";
    }
  }

  @override
  Future<AppUser?> signInWithApple() async {
    try {
      // request Apple ID credentials
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName
        ],
      );

      // Create an OAuth credential
      final oAuthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      // sign in with the credential
      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(oAuthCredential);

      // firebase user
      final firebaseUser = userCredential.user;

      // user cancelled the sign-in
      if (firebaseUser == null) return null;

      // create app user
      AppUser appUser = AppUser(
        uid: firebaseUser.uid,
        email: firebaseUser.email ?? '',
      );
      return appUser;
    } catch (e) {
      print('Error signing in with Apple: $e');
      return null;
    }
  }

  @override
  Future<AppUser?> signInWithGoogle() async {
    try {
      // begin the interactive sign-in process
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      // user cancelled sign-in
      if (gUser == null) return null;

      // obtain auth details from request
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // create a credential for the user
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // sign in with these credentials
      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);

      // firebase user
      final firebaseUser = userCredential.user;

      // user cancelled sign-in process
      if (firebaseUser == null) return null;

      AppUser appUser = AppUser(
        uid: firebaseUser.uid,
        email: firebaseUser.email ?? '',
      );

      return appUser;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
