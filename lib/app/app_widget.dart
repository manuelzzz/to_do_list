import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_list/app/core/database/sqlite_adm_connection.dart';
import 'package:todo_list/app/core/navigator/todo_list_navigator.dart';
import 'package:todo_list/app/core/ui/todo_list_ui_config.dart';
import 'package:todo_list/app/modules/auth/auth_module.dart';
import 'package:todo_list/app/modules/home/home_module.dart';
import 'package:todo_list/app/modules/splash/splash_page.dart';
import 'package:todo_list/app/modules/tasks/task_module.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final sqliteAdmConnection = SqliteAdmConnection();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(sqliteAdmConnection);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(sqliteAdmConnection);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo list',
      debugShowCheckedModeBanner: false,
      theme: TodoListUiConfig.theme,
      routes: {
        ...AuthModule().routers,
        ...HomeModule().routers,
        ...TaskModule().routers
      },
      navigatorKey: TodoListNavigator.navigatorKey,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      home: const SplashPage(),
    );
  }
}
