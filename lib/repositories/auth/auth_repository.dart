import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:semesterproject/repositories/auth/base_auth_repository.dart';
import 'package:semesterproject/repositories/user/user_base_repository.dart';

import '../../models/models.dart';

class AuthRepository extends BaseAuthRepository {
  final auth.FirebaseAuth _firebaseAuth;
  final UserRepository _userRepository;
  final GoogleSignIn _googleSignIn;
  AuthRepository(
      {auth.FirebaseAuth? firebaseAuth,
      GoogleSignIn? googleSignIn,
      required UserRepository userRepository})
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
        _userRepository = userRepository,
        _googleSignIn =
            googleSignIn ?? GoogleSignIn.standard(scopes: ['email']);

  @override
  Future<auth.User?> signUp(
      {required User user, required String password}) async {
    try {
      _firebaseAuth
          .createUserWithEmailAndPassword(
            email: user.email,
            password: password,
          )
          .then((value) => _userRepository.createUser(
                user.copyWith(id: value.user!.uid),
              ));
    } catch (_) {}
  }

  @override
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (_) {}
  }

  @override
  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> loginWithGoogle() async {
    try {
      late final auth.AuthCredential credential;
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;

      credential = auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      _firebaseAuth.signInWithCredential(credential).then(
            (value) => {
              _userRepository.createUser(User(
                id: value.user!.uid,
                fullName: value.user!.displayName ?? '',
                email: value.user!.email ?? '',
              ))
            },
          );
    } catch (_) {}
  }
}
