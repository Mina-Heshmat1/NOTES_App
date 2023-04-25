import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Styets.dart';

class CounterCubit extends Cubit<CounterStates> {
  //هنا انا عملت كلاس وقلتلو انت هتفتح على الصفحه الرئيسيه الى هيا الانشيل
  CounterCubit() : super(CounterInitialState());

//علاشان اقدر اتحكم فيه لازم يكون استتك بلطريقه دى علاشان اقدرا استدعى الى جواها
  static CounterCubit get(context) => BlocProvider.of(context);
  int index = 0;

  void Minus()
  {
    index--;
    emit(CounterMinusState());
  }
  void Plas()
  {
    index++;
    emit(CounterPlasState());
  }

}
