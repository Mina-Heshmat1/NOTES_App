import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../shared/componentc/conponentc.dart';
import '../../shared/styles/colors.dart';
import 'Cubit/Cubit.dart';
import 'Cubit/Styets.dart';

class TodoLayout extends StatelessWidget {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var FormKey = GlobalKey<FormState>();
  var taskTitleController = TextEditingController();
  var TimeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=>TodoCubit()..createDatabase(),
      child: BlocConsumer<TodoCubit,TodoStates>(
        listener: (context,states){},
        builder: (context,states){
          return Scaffold(
            key: scaffoldkey,
            appBar: AppBar(
              backgroundColor: bLUYThree,
              title: Text(
                TodoCubit.get(context).appBartitle[TodoCubit.get(context).currentIndex],
                style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w900),
              ),
            ),
            body: TodoCubit.get(context).screens[TodoCubit.get(context).currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: bLUYTOW,
              selectedItemColor: Colors.yellowAccent,
              //كارنت اندكس معنها النص الحالى الى انا لما افتح الابلكيشن عايز انهى صفحه الاول
              currentIndex: TodoCubit.get(context).currentIndex,
              //معنها عند الضغط على اي على النص فا النصي الحالى هيكون هو النص المضغوط عليهي
              onTap: (index) {
                TodoCubit.get(context).ChangeScreen(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu), label: "TASKS"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.done_outline_outlined), label: "DONE"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: "ARCHIVE"),
              ],
            ),
            //الى هو الزرار المدور
            floatingActionButton: FloatingActionButton(
              backgroundColor: Gold,
              onPressed: () async {
                if(TodoCubit.get(context).isBottomSheet)
                { if(FormKey.currentState!.validate())
                {
                  if(TodoCubit.get(context).database!=null){
                    TodoCubit.get(context).InsertToDatabesa(title: taskTitleController.text,
                        date: dateController.text,
                        time: TimeController.text
                    );
                  }
                }
                }else{
                  scaffoldkey.currentState!.showBottomSheet((context) => Container(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key:FormKey ,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //هنعمل استدعاء للنص عن طريق ادخلو فى صفحه خارجه واستدعاء
                            TextFormFieldCusstom(
                              controller: taskTitleController,
                              label: "Tasks",
                              //علاشان اعمل ايقونه على اليمين
                              //suffixIcon: Icons.title,
                              //علاشان اعمل ايقونه على اليسار ولازم تكون متعرفه كدله فى الكلاس الى انا بشتق منة
                              prifixIcon: Icons.title,
                              validator: (value)
                              {
                                if(value.isEmpty)
                                {
                                  return'Please Complete Yor Informations';
                                }
                                return null ;
                              }
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormFieldCusstom(
                                controller: TimeController,
                                label: "Time",
                                //علاشان اعمل ايقونه على اليمين
                                //suffixIcon: Icons.title,
                                //علاشان اعمل ايقونه على اليسار ولازم تكون متعرفه كدله فى الكلاس الى انا بشتق منة
                                prifixIcon: Icons.timer,
                                validator: (value)
                                {
                                  if(value.isEmpty)
                                  {
                                    return'Please Complete Yor Informations';
                                  }
                                  return null ;
                                },
                                //علاشان احدد الوقت انى ابداء من بدايه تشغيل البرنامج
                                OnTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) => {
                                    TimeController.text =
                                        value!.format(context).toString()
                                  });
                                }),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormFieldCusstom(
                                controller: dateController,
                                label: "DATE",
                                //علاشان اعمل ايقونه على اليمين
                                //suffixIcon: Icons.title,
                                //علاشان اعمل ايقونه على اليسار ولازم تكون متعرفه كدله فى الكلاس الى انا بشتق منة
                                prifixIcon: Icons.calendar_today,
                                validator: (value)
                                {
                                  if(value.isEmpty)
                                  {
                                    return'Please Complete Yor Informations';
                                  }
                                  return null ;                                },
                                OnTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2025-10-12'),
                                  ).then((value) {
                                    dateController.text =
                                        DateFormat.yMMMMd().format(value!);
                                  });
                                }),
                            //كدة دول متكررين طيب متيجى نعمل كلاس ونشتق منو كل دة بعد معمل الكلاس همسحهم
                            /*TextFormField(
                            //علاشان اقدر تحكم فى المستطيل هعملو كنترول
                          controller:taskTitleController ,
                          //علاشان اخليه يدينى رساله لما تكون الخانه فاضيا
                          validator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return"Tital Must Not Be Empty";
                            }
                          },
                          //علاشان احدد الى هيتكتب فى المربع رقم او نص او
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "TASK TITAL",
                            //علاشان اعمل علامه النص فى المربع على اليمين
                            prefix: Icon(Icons.title),
                             //علاشان اعمل علامه النص فى المربع على اليسار
                            //suffixIcon: Icon(Icons.title),
                            border: OutlineInputBorder(
                              //علاشا اخلى المستطيل الى هكتب فيه مدور
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(width: 1,color: Colors.white,),
                            ),
                            ),
                          ),
                        SizedBox(height: 15,),
                        TextFormField(
                          controller:taskTitleController ,
                          //علاشان اخليه يدينى رساله لما تكون الخانه فاضيا
                          validator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return"Tital Must Not Be Empty";
                            }
                          },
                          //علاشان احدد الى هيتكتب فى المربع رقم او نص او
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "TASK TITAL",
                            //علاشان اعمل علامه النص فى المربع على اليمين
                            prefix: Icon(Icons.title),
                            //علاشان اعمل علامه النص فى المربع على اليسار
                            //suffixIcon: Icon(Icons.title),
                            border: OutlineInputBorder(
                              //علاشا اخلى المستطيل الى هكتب فيه مدور
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(width: 1,color: Colors.white,),
                            ),
                          ),
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          controller:taskTitleController ,
                          //علاشان اخليه يدينى رساله لما تكون الخانه فاضيا
                          validator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return"Tital Must Not Be Empty";
                            }
                          },
                          //علاشان احدد الى هيتكتب فى المربع رقم او نص او
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "TASK TITAL",
                            //علاشان اعمل علامه النص فى المربع على اليمين
                            prefix: Icon(Icons.title),
                            //علاشان اعمل علامه النص فى المربع على اليسار
                            //suffixIcon: Icon(Icons.title),
                            border: OutlineInputBorder(
                              //علاشا اخلى المستطيل الى هكتب فيه مدور
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(width: 1,color: Colors.white,),
                            ),
                          ),
                        ),*/
                          ],
                        ),
                      ),
                    ),
                  )
                  ).closed.then((value){
                    TodoCubit.get(context).changeBottomSheet(isOpend: false, iconData: Icons.edit);
                  });

                  TodoCubit.get(context).changeBottomSheet(isOpend: true, iconData: Icons.add);
                }

                AudioCache audioCache = AudioCache();
                final file = await audioCache . loadAsFile('music/myzek2.mp3');
                final bytes = await file .readAsBytes();
                audioCache.playBytes(bytes);
              },
              child: Icon(
                TodoCubit.get(context).fab,
                color: Colors.white,
                size: 30,
              ),
            ),
          );
        },
      ),
    );
  }
}


