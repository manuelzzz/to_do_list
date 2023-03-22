import 'package:todo_list/app/core/database/sqlite_connection_factory.dart';
import 'package:todo_list/app/models/task_model.dart';
import 'package:todo_list/app/repositories/tasks/tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  TasksRepositoryImpl(
      {required SqliteConnectionFactory sqliteConnectionFactory})
      : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<void> save(DateTime date, String description) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.insert(
      'todo',
      {
        'id': null,
        'descricao': description,
        'data_hora': date.toIso8601String(),
        'finalizado': 0
      },
    );
  }

  @override
  Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end) async {
    final startFilter = DateTime(start.year, start.month, start.day, 0, 0, 0);
    final endFilter = DateTime(end.year, end.month, end.day, 23, 59, 59);

    final conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn.rawQuery(
      '''
        select *
        from todo
        where data_hora between ? and ?
        order by data_hora
        ''',
      [
        startFilter.toIso8601String(),
        endFilter.toIso8601String(),
      ],
    );
    return result.map((e) => TaskModel.loadFromDB(e)).toList();
  }

  @override
  Future<void> checkOrUncheckTask(TaskModel task) async {
    final conn = await _sqliteConnectionFactory.openConnection();

    await conn.rawUpdate(
      'update todo set finalizado = ? where id = ?',
      [
        task.finished,
        task.id,
      ],
    );
  }

  @override
  Future<void> delete(TaskModel task) async {
    final conn = await _sqliteConnectionFactory.openConnection();

    await conn.rawDelete(
      'delete todo where id = ?',
      [
        task.id,
      ],
    );
  }
}
