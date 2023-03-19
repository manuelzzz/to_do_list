import 'package:flutter/foundation.dart';
import 'package:todo_list/app/core/notifier/todo_list_change_notifier.dart';
import 'package:todo_list/app/core/ui/messages.dart';
import 'package:todo_list/app/exceptions/auth_exception.dart';
import 'package:todo_list/app/services/user/user_service.dart';

class LoginController extends TodoListChangeNotifier {
  final UserService _userService;
  String? infoMessage;

  LoginController({required UserService userService})
      : _userService = userService;

  bool get hasInfo => infoMessage != null;
  void resetInfo() => infoMessage = null;

  Future<void> login(String email, String password) async {
    try {
      showLoadingAndResetState();
      resetInfo();
      notifyListeners();

      final user = await _userService.login(email, password);

      if (user != null) {
        success();
      } else {
        setError('E-mail ou senha inválidos');
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> googleLogin() async {
    try {
      showLoadingAndResetState();
      resetInfo();
      notifyListeners();

      final user = await _userService.googleLogin();

      if (user != null) {
        success();
      } else {
        setError('Não foi possível realizar o login com o google');
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      showLoadingAndResetState();
      resetInfo();
      notifyListeners();

      await _userService.forgotPassword(email);
      infoMessage = 'Alterar senha enviado para o seu e-mail';
    } on AuthException catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }

      setError(e.message);
    } catch (e) {
      setError('Erro ao alterar a senha');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
