
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:bitirmeprojesi/ui/screen/anasayfa.dart';
import 'package:bitirmeprojesi/ui/screen/bottum/bottum_page.dart';
import 'package:bitirmeprojesi/ui/screen/loginn.dart';

class LoginForm{
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<User?> signIn(String emailControl, String passwordControl) async {
    var user = await auth.signInWithEmailAndPassword(
        email: emailControl, password: passwordControl);
    try{
      return user.user;
    } catch (e) {
      print(e);
    }

  }
  Future<void> signOut() async {
    return await auth.signOut();
  }



}

class AuthService{
  //Determine if the user is authenticated.
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return BottumSayfa();
          } else {
            return const Login();
          }
        });
  }

  signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: <String>["muhihsanalptekin@gmail.com"]).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }


}