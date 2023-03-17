import 'package:flutter/material.dart';
import 'package:todo_list/app/exceptions/auth_exception.dart';
import 'package:todo_list/app/services/user/user_service.dart';

class RegisterController extends ChangeNotifier {
  final UserService _userService;
  String? erro;
  bool sucesso = false;

  RegisterController({required UserService userService})
      : _userService = userService;

  Future<void> registerUser(String email, String password) async {
    try {
      erro = null;
      sucesso = false;
      notifyListeners();

      final user = await _userService.register(email, password);

      if (user != null) {
        sucesso = true;
      } else {
        erro = 'Erro ao registrar usuário';
      }
    } on AuthException catch (e) {
      erro = e.message;
    } finally {
      notifyListeners();
    }
  }
}
