import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_mate/controllers/cubit/states.dart';

import 'package:sqflite/sqflite.dart';

import '../../views/todo and mission/done.dart';
import '../../views/todo and mission/newtodo.dart';
import '../../views/todo and mission/starredtodo.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());
  static AppCubit get(context) => BlocProvider.of(context);

  late Database db;
  List<Map> newtasks = [];
  List<Map> tasks = [];
  List<Map> startasks = [];

  List<Map> donetasks = [];
  List<Widget> screens = [
    const NewTodo(),
    const DoneTodo(),
    const StarredTodo(),
  ];
  List<String> titles = [
    'المهام اليومية',
    'المهام المنجزة',
    'المهام المميزة بنجمة',
  ];

  var currentIndex = 0;

  void changescreens(int index) {
    currentIndex = index;
    emit(AppScreenState());
  }

  void createDatabase() {
    openDatabase('todotasks.db', version: 1, onCreate: (db, version) {
      db
          .execute(
              'CREATE TABLE todotasks (id INTEGER PRIMARY KEY,star INTEGER, date TEXT, title TEXT, disc TEXT, time TEXT,done TEXT)')
          // ignore: avoid_print
          .then((value) => print('table created'))
          // ignore: avoid_print
          .catchError((onError) => print('error found'));
    }, onOpen: (db) {
      //
      // ignore: avoid_print
      print('database opened');
    }).then((value) {
      db = value;
      getDatafromDatabase(db);
      emit(AppcreateDatabaseState());
    });
  }

  void updateStatus({required int id, required String done}) async {
    db.rawUpdate('UPDATE todotasks SET done = ? WHERE id = ?', [done, id]).then(
        (value) {
      getDatafromDatabase(db);
      emit(ApptDatabaseUpdateState());
    });
  }

  void deleteStatus({required int id}) async {
    db.rawDelete('DELETE FROM todotasks WHERE id = ?', [id]).then((value) {
      getDatafromDatabase(db);
      emit(ApptDatabaseDeleteState());
    });
  }

  insertToDatabase({
    required String title,
    required String disc,
    required String date,
    required String time,
    required bool star,
  }) async {
    await db.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO todotasks( star, date, title, disc, time,done) VALUES("$star","$date","$title","$disc","$time","False" )')
          .then((value) {
        if (kDebugMode) {
          print('$value inserted successfully');
        }
        emit(AppinsertDatabaseState());
        getDatafromDatabase(db);
      }).catchError((error) {
        if (kDebugMode) {
          print('errorfound ${error.toString()}');
        }
      });
    });
  }

  void getDatafromDatabase(db) {
    newtasks = [];
    donetasks = [];
    startasks = [];
    emit(ApptDatabaseLoadState());
    db.rawQuery('SELECT * FROM todotasks').then(
      (value) {
        tasks = value;
        for (var task in tasks) {
          if (task['done'] == 'true') {
            donetasks.add(task);
          } else {
            newtasks.add(task);
          }

          if (task['star'] == 'true') {
            startasks.add(task);
          }
        }
        if (kDebugMode) {
          print(startasks);
        }

        emit(AppgetDatabaseState());
      },
    );
  }
}
