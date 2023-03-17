import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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
}
