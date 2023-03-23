import 'package:flutter/material.dart';
import 'package:todo_list/app/core/ui/theme_extensions.dart';

class HomeConfirmTaskDelete {
  static bool confirm = false;

  static Future<void> cancelDialog({
    required BuildContext context,
  }) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deseja excluir essa task?'),
          actions: [
            TextButton(
              onPressed: () {
                confirm = false;
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancelar',
                style: TextStyle(color: context.primaryColor),
              ),
            ),
            TextButton(
              onPressed: () {
                confirm = true;
                Navigator.of(context).pop();
              },
              child: const Text(
                'Sim',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
