import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/user_entity.dart';

class FirebaseAuthDatasource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserEntity?> signIn(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserEntity(uid: result.user!.uid, email: result.user!.email);
  }

  Future<UserEntity?> signUp(String email, String password) async {
    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserEntity(uid: result.user!.uid, email: result.user!.email);
  }

  Future<void> signOut() => _auth.signOut();

  UserEntity? getCurrentUser() {
    final user = _auth.currentUser;
    if (user != null) return UserEntity(uid: user.uid, email: user.email);
    return null;
  }
}
