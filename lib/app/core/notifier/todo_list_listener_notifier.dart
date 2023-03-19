import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:todo_list/app/core/notifier/todo_list_change_notifier.dart';
import 'package:todo_list/app/core/ui/messages.dart';

class TodoListListenerNotifier {
  final TodoListChangeNotifier changeNotifier;

  TodoListListenerNotifier({
    required this.changeNotifier,
  });

  void listener({
    required BuildContext context,
    required SuccessCallback successCallback,
    ErrorCallback? errorCallback,
  }) {
    changeNotifier.addListener(() {
      if (changeNotifier.loading) {
        Loader.show(context);
      } else {
        Loader.hide();
      }

      if (changeNotifier.hasError) {
        if (errorCallback != null) {
          errorCallback(changeNotifier, this);
        }

        Messages.of(context).showError(changeNotifier.error ?? 'Erro interno');
      } else if (changeNotifier.isSuccess) {
        successCallback(changeNotifier, this);
      }
    });
  }
}

typedef SuccessCallback = void Function(
  TodoListChangeNotifier notifier,
  TodoListListenerNotifier listenerInstance,
);

typedef ErrorCallback = void Function(
  TodoListChangeNotifier notifier,
  TodoListListenerNotifier listenerInstance,
);
