import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/app_widget.dart';
import 'package:todo_list/app/core/database/sqlite_connection_factory.dart';

class AppModule extends StatelessWidget {
  const AppModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => SqliteConnectionFactory(),
          lazy: false,
        ),
      ],
      child: const AppWidget(),
    );
  }
}
