import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/todoapp/Cubit/Cubit.dart';
import '../../../layout/todoapp/Cubit/Styets.dart';
import '../../../shared/componentc/conponentc.dart';

class DoneScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (context, states) {},
      builder: (context, states) {
        return Scaffold(
          body: BuildCondition(
            condition: TodoCubit.get(context).doneTask.length > 0,
            builder: (context)=>ListTodo(task: TodoCubit.get(context).doneTask,),
            fallback: (context)=>Center(child: CircularProgressIndicator(),),
          ),
        );
      },
    );
  }
}


