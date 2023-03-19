import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_list/app/modules/auth/auth_module.dart';
import 'package:todo_list/app/repositories/user/user_repository.dart';
import '../../exceptions/auth_exception.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      // email-already-exists
      if (e.code == 'email-already-in-use') {
        final loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);

        if (loginTypes.contains('password')) {
          throw AuthException(
            message: 'E-mail já ultilizado, por favor, logue com outro e-mail',
          );
        } else {
          throw AuthException(
            message:
                'Você se cadastrou no TodoList pelo google, por favor, ultilize ele para entrar',
          );
        }
      } else {
        throw AuthException(
          message: e.message ?? 'Erro ao registrar usuário',
        );
      }
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user;
    } on PlatformException catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }

      throw AuthException(message: e.message ?? 'Erro ao realizar o login');
    } on FirebaseAuthException catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }

      if (e.code == 'wrong-password' || e.code == 'user-not-found') {
        throw AuthException(message: 'Login ou senha inválida');
      }

      throw AuthException(message: e.message ?? 'Erro ao realizar o login');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      final loginMethods =
          await _firebaseAuth.fetchSignInMethodsForEmail(email);

      if (loginMethods.contains('password')) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } else if (loginMethods.contains('google')) {
        throw AuthException(
            message:
                'Cadastro realizado com o google. A senha não pode ser alterada');
      } else {
        throw AuthException(message: 'E-mail não cadastrado');
      }
    } on PlatformException catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      throw AuthException(message: 'Erro ao alterar a senha');
    }
  }

  @override
  Future<User?> googleLogin() async {
    List<String>? loginMethods;
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        loginMethods =
            await _firebaseAuth.fetchSignInMethodsForEmail(googleUser.email);

        if (loginMethods.contains('password')) {
          throw AuthException(
            message:
                'Você já ultilizou este e-mail para cadastro no TodoList. Caso tenha esuecido sua senha, clique em "Esqueceu sua senha?"',
          );
        } else {
          final googleAuth = await googleUser.authentication;
          final firebaseCredential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          final userCredential =
              await _firebaseAuth.signInWithCredential(firebaseCredential);

          return userCredential.user;
        }
      }
    } on FirebaseAuthException catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }

      if (e.code == 'account-exists-with-different-credential') {
        throw AuthException(message: '''
                Login inváilido, você se registrou no TodoList com os seguintes provedores:
                ${loginMethods?.join(',')}
                ''');
      } else {
        throw AuthException(message: 'Erro ao realizar login');
      }
    }
  }
}
