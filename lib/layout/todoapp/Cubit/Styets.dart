abstract class TodoStates{}

class TodoInitialState extends TodoStates{}

class ChangeScreenState extends TodoStates{}

class AppCreatDatabaseState extends TodoStates{}

class AppInsertDatabaseState extends TodoStates{}

class GetDateState extends TodoStates{}

class UPdetaDateState extends TodoStates{}

class deleteDateState extends TodoStates{}

class GetDateLodingState extends TodoStates{}

class ChaneFabIconState extends TodoStates{}

class AppInsertDatabaseErrorState extends TodoStates
{
  String error;
  AppInsertDatabaseErrorState(this.error);
}
class GetDataErrorState extends TodoStates
{
  String error;
  GetDataErrorState(this.error);
}



