import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthDataSource {
  final FirebaseAuth firebaseAuth;

  GoogleAuthDataSource({
    required this.firebaseAuth,
  });

  Future<void> initialize() async {
    await GoogleSignIn.instance.initialize();
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      await initialize();

      final GoogleSignInAccount googleUser =
      await GoogleSignIn.instance.authenticate();

      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      return await firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      print('Google Sign-In Error: $e');
      rethrow;
    }
  }
}