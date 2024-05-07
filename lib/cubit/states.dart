
abstract class HomeScreenStates{}

class HomeScreenInitialState extends HomeScreenStates{}

class ClickOnAddButtonState extends HomeScreenStates{}

class ChangeCurrentIndexState extends HomeScreenStates{}

class tttttState extends HomeScreenStates{}

class AddBranchLoadingState extends HomeScreenStates{}
class AddBranchSuccessState extends HomeScreenStates{}
class AddBranchErrorState extends HomeScreenStates{
  final String error;
  AddBranchErrorState(this.error);
}

class GetAllBranchesLoadingState extends HomeScreenStates{}
class GetAllBranchesSuccessState extends HomeScreenStates{}
class GetAllBranchesErrorState extends HomeScreenStates{
  final String error;
  GetAllBranchesErrorState(this.error);
}


































