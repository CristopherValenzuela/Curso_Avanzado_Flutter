import 'package:firebase_auth/firebase_auth.dart';
import 'package:curzo_avanzado_flutter_plat/User/repository/firebase_auth_api.dart';

class AuthRepository{

  final _firebaseAuthAPI = FirebaseAuthAPI();
  //En el future se usa UserCredential por que asi esta definido en firebase_auth_api
  Future<UserCredential> signInFirebase() => _firebaseAuthAPI.signInWithGoogle();

  signOut() => _firebaseAuthAPI.signOut();

}