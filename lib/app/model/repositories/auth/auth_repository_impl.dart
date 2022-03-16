import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_getx_isar/app/data/firebase/auth/auth_source.dart';
import 'package:todo_getx_isar/app/data/firebase/auth/auth_source_exception.dart';

class AuthSourceImpl implements AuthSource {
  FirebaseAuth _firebaseAuth;
  AuthSourceImpl({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;
  @override
  Future<User?> register(
      {required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e, s) {
      // //print(e);
      // //print(s);
      // if (e.code == 'email-already-exists') {
      if (e.code == 'email-already-in-use') {
        final loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);

        if (loginTypes.contains('password')) {
          throw AuthSourceException(message: 'E-mail ja utilizado.');
        } else {
          throw AuthSourceException(
              message:
                  'Você esta cadastrado pelo Google. Então, entre pelo Google !!!');
        }
      } else {
        throw AuthSourceException(
            message: e.message ?? 'Erro ao registrar usuário.');
      }
    }
  }

  @override
  Future<User?> loginEmail(
      {required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on PlatformException catch (e, s) {
      // print(e);
      // print(s);
      throw AuthSourceException(
          message: e.message ?? 'Erro de PlatformException ao realizar login');
    } on FirebaseAuthException catch (e, s) {
      print('...>e.code: ${e.code}');
      // print(s);

      if (e.code == 'invalid-email') {
        throw AuthSourceException(message: 'Email não válido');
      }
      if (e.code == 'user-disabled') {
        throw AuthSourceException(
            message: 'Usuario desabilitado para o email consultado.');
      }
      if (e.code == 'user-not-found') {
        throw AuthSourceException(
            message: 'Não há usuário correspondente a este email');
      }
      if (e.code == 'wrong-password') {
        throw AuthSourceException(message: 'Senha inválida para este email');
      }

      throw AuthSourceException(
          message:
              'Erro desconhecido no FirebaseAuthException ao realizar login');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      final loginTypes = await _firebaseAuth.fetchSignInMethodsForEmail(email);

      if (loginTypes.contains('password')) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } else if (loginTypes.contains('google')) {
        throw AuthSourceException(
            message:
                'Você esta cadastrado pelo Google. Nao precisa recuperar senha !!!');
      } else {
        throw AuthSourceException(message: 'Email não encontrado');
      }
    } on PlatformException catch (e, s) {
      // //print(e);
      // //print(s);
      throw AuthSourceException(
          message: e.message ?? 'Erro de PlatformException ao realizar login');
    } on FirebaseAuthException catch (e, s) {
      // //print(e);
      // //print(s);
      throw AuthSourceException(
          message:
              'Erro desconhecido no FirebaseAuthException ao realizar login');
    }
  }

  @override
  Future<User?> loginGoogle() async {
    List<String>? loginMethods;
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        loginMethods =
            await _firebaseAuth.fetchSignInMethodsForEmail(googleUser.email);
        if (loginMethods.contains('password')) {
          throw AuthSourceException(
              message:
                  'Você esta cadastrado com email. E deve logar com email.');
        } else {
          final googleAuth = await googleUser.authentication;
          final firebaseCredential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          var userCredential =
              await _firebaseAuth.signInWithCredential(firebaseCredential);
          return userCredential.user;
        }
      }
    } on PlatformException catch (e, s) {
      // //print(e);
      // //print(s);
      throw AuthSourceException(
          message: e.message ?? 'Erro de PlatformException ao realizar login');
    } on FirebaseAuthException catch (e, s) {
      // //print(e);
      // //print(s);
      if (e.code == 'account-exists-with-different-credential') {
        throw AuthSourceException(
            message:
                'Login inválido. Você se registrou com ${loginMethods?.join(",")}');
      } else {
        throw AuthSourceException(
            message:
                'Erro desconhecido no FirebaseAuthException ao realizar login');
      }
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    _firebaseAuth.signOut();
  }

  @override
  Future<void> updateDisplayName(String name) async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await user.updateDisplayName(name);
      user.reload();
    }
  }

  @override
  Future<void> updatePhotoURL(String photoUrl) async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await user.updatePhotoURL(photoUrl);
      user.reload();
    }
  }
}
