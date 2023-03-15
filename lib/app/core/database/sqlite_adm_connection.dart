import 'package:flutter/material.dart';
import 'package:todo_list/app/core/database/sqlite_connection_factory.dart';

/// Monitoring the application status
///
/// to cut off Sqlite connection when the app get closed
class SqliteAdmConnection with WidgetsBindingObserver {
  final connection = SqliteConnectionFactory();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        connection.closeConnection();
        break;
    }
    super.didChangeAppLifecycleState(state);
  }
}
