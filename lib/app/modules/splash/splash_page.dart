import 'package:flutter/material.dart';
import 'package:todo_list/app/core/widget/todo_list_logo.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: TodoListLogo(),
      ),
    );
  }
}
