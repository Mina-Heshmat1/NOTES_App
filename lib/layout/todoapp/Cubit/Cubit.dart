import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/layout/todoapp/Cubit/Styets.dart';
import 'package:sqflite/sqflite.dart';
import '../../../modules/TodoApp/archivescreen/archivescreen.dart';
import '../../../modules/TodoApp/donescreen/donescreen.dart';
import '../../../modules/TodoApp/tasksscreen/tasksscreen.dart';


class TodoCubit extends Cubit<TodoStates> {
  TodoCubit() : super(TodoInitialState());

  static TodoCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  Database database;
  IconData fab = Icons.edit;
  bool isBottomSheet = false;
  List<Map> newTask =[];
  List<Map> doneTask =[];
  List<Map> ArchiveTask =[];

  List<Widget> screens = [
    TasksScreen(),
    DoneScreen(),
    ArchiveScreen(),
  ];

  //هعمل اب بار علاشان يقلب معايا في كل الاسكرينات واحط اسمو فى لاب بار الرئيسي الى عندى تحت
  List<String> appBartitle = [
    "Tasks Screen",
    "Done Screen",
    "Archive Screen",
  ];

  void ChangeScreen(index) {
    currentIndex = index;
    emit(ChangeScreenState());
  }

  void createDatabase() {
    openDatabase("TODO.db", version: 1, onCreate: (database, verion) {
      print("DATA BASE Created");
      //الى احنا محتجينو
      //id integer
      //title string
      // date string
      // time string
      // status string
      database
          .execute(
          'CREATE TABLE Test (id INTEGER PRIMARY KEY, title TEXT,date TEXT,  time TEXT, status TEXT)')
          .then((value) {
        print('table created');
      }).catchError((error) {
        print('Error when creating table${error.toString()}');
      });
    }, onOpen: (database) {
      getDateFromDatebase(database);
      print('datebase opened');
    }).then((value) {
      database = value;
      emit(AppCreatDatabaseState());
    });
  }

  void changeBottomSheet(
      {required bool isOpend, required IconData iconData}) {
    isBottomSheet = isOpend;
    fab = iconData;
    emit(ChaneFabIconState());
  }
// 1
  Future InsertToDatabesa({
    required String title,
    required String date,
    required String time,
  }) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
          'INSERT INTO Test(title, date, time, status) VALUES("${title}","${date}","${time}","new")')
          .then((value) {
        getDateFromDatebase(database);
        print('$value inserted successfuly');
        emit(AppInsertDatabaseState());
      }).catchError((error) {
        emit(AppInsertDatabaseErrorState(error.toString()));
      });
      return null!;
    });
  }

  void getDateFromDatebase(Database database) {
    emit(GetDateLodingState());
    newTask.clear();
    doneTask.clear();
    ArchiveTask.clear();
    database.rawQuery('SELECT * FROM Test').then((value) {
      value.forEach((element)
      {
        if(element['status']=='new'){
          newTask.add(element);
        }else if(element['status']=="done")
        {
          doneTask.add(element);
        }else{
          ArchiveTask.add(element);
        }
      });
      emit(GetDateState());
    }).catchError((error){
      emit(GetDataErrorState(error));
    });
  }

  void UPdetaDate({required String status,required int id })
  {
    database.rawUpdate(
      "UPDATE test SET status =? WHERE id = ?",
      [status,id],
    ).then((value) {
      getDateFromDatebase(database);
      emit(UPdetaDateState());
    });
  }


  void deleteData({@required id})
  {
    database.rawDelete(
        "DELETE FROM test WHERE id =? ",[id]
    ).then((value)
    {
      getDateFromDatebase(database);
      emit(deleteDateState());
    });
  }
}
