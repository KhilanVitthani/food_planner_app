import 'package:food_planner_app/models/selected_model.dart';
import 'package:food_planner_app/models/user.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _dbUser;
  static Database? _dbAttendance;
  static final int _versoin = 1;
  static final String _tableUser = "user";
  static final String _tableAttendance = "foodAttendance";

  Future<void> initDb() async {
    if (_dbUser != null && _dbAttendance != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + "user.db";
      _dbUser = await openDatabase(
        _path,
        version: _versoin,
        onCreate: (db, version) {
          print("Create a new one");
          db.execute(
            "CREATE TABLE $_tableAttendance("
            "id INTEGER, "
            "date STRING,time STRING,status INTEGER)",
          );
          db
              .execute(
            "CREATE TABLE $_tableUser("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "name STRING,location STRING)",
          )
              .then((value) {
            print("value");
          });
        },
      );

      print(_dbAttendance);
    } catch (e) {
      print(e);
    }
  }

  Future<int> insertUserTable(UserModels? task) async {
    print("insert function called");
    return await _dbUser?.insert(_tableUser, task!.toJson()) ?? 1;
  }

  Future<int> insertAttendanceTable(SelectedModels? task) async {
    print("insert function called");
    return await _dbUser?.insert(_tableAttendance, task!.toJson()) ?? 1;
  }

  Future<List<Map<String, dynamic>>> queryUser() async {
    print("query function called");
    return await _dbUser!.query(_tableUser);
  }

  Future<List<Map<String, dynamic>>> queryAttendance() async {
    print("query function called");
    return await _dbUser!.query(_tableAttendance);
  }

  // static delete(Task task) async {
  //   return await _db!.delete(_tableUser, where: 'id=?', whereArgs: [task.id]);
  // }
  Future<List<Map<String, dynamic>>> getDataFromDate(
      {required String date, required String time}) async {
    return await _dbUser!.rawQuery(
        'SELECT * FROM $_tableAttendance WHERE (date = ? AND time=?)',
        [date, time]);
  }

  update({required int id, required RxInt status}) async {
    return await _dbUser!.rawUpdate('''
        UPDATE $_tableAttendance
        SET status = ?
        WHERE id =?
      ''', [status.value, id]).then((value) {
      print(value);
    });
  }
}
