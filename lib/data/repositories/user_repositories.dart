import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth _fireBaseAuth;

  UserRepository({FirebaseAuth firebaseAuth}): _fireBaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> signInWithCredentials(String email, String password)  {
    return _fireBaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUpWithCredentials(String email, String password) async {
    return await _fireBaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    return Future.wait([_fireBaseAuth.signOut()]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _fireBaseAuth.currentUser;
    return currentUser != null;
  }

  Future<User> getCurrentUser() async {
    return _fireBaseAuth.currentUser;
  }
}