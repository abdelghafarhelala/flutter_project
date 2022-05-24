import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_second/layout/todo_app/cubit/states.dart';
import 'package:flutter_second/shared/cache_Helper.dart';

import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  var isDark = false;
  void changeAppTheme({bool? fromCache}) {
    if (fromCache != null) {
      isDark = fromCache;
      emit(AppChangeThemState());
    } else {
      isDark = !isDark;
      CacheHelper.setBoolean(key: 'isDark', value: isDark).then((value) {
        print('success');
        emit(AppChangeThemState());
      });
    }
  }

  late Database database;
  List<Map> newPosts = [];

  void createDatabase() {
    openDatabase(
      'social.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'CREATE TABLE posts (id INTEGER PRIMARY KEY, title TEXT, content TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    required String title,
    required String content,
  }) async {
    await database.transaction((txn) {
      return txn
          .rawInsert(
        'INSERT INTO posts(title,content) VALUES("$title","$content")',
      )
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        print('Error when inserting New Record${error.toString()}');
      });
    });
  }

  void getDataFromDatabase(database) {
    newPosts = [];

    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT *FROM posts').then((value) {
      print(value);
      value.forEach((element) {
        newPosts.add(element);
      });
      emit(AppGetDatabaseState());
    });
  }

  void updateData({
    required String title,
    required String content,
    required int id,
  }) async {
    emit(AppGetDatabaseLoadingState());
    database.rawUpdate('UPDATE posts SET title = ? ,content = ? WHERE id = ?',
        [title, content, id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({
    required int id,
  }) async {
    database.rawDelete('Delete From posts WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }
}
