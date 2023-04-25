
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Cubit/Cubit.dart';
import 'Cubit/Styets.dart';

class ConterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=>CounterCubit(),
      child: BlocConsumer<CounterCubit,CounterStates>(
        listener: (context,States){},
        builder: (context,states){
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          CounterCubit.get(context).Minus();
                        },
                        child: Text(
                          "-",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        )),
                    SizedBox(width: 20,),
                    Text("${CounterCubit.get(context).index}",style: TextStyle(fontSize: 40,),),
                    SizedBox(width: 20,),
                    TextButton(
                        onPressed: () {
                          CounterCubit.get(context).Plas();

                        },
                        child: Text(
                          "+",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        )),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

