import 'package:crud_task/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_task/data_layer/models/branches_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenCubit extends Cubit<HomeScreenStates> {

  HomeScreenCubit() : super(HomeScreenInitialState());

  static HomeScreenCubit get(context) => BlocProvider.of(context);

  bool addButtonClick=false;

  void clickAddButton(){
    addButtonClick=!addButtonClick;
    emit(ClickOnAddButtonState());
  }

  int currentIndex=0;
  void changeCurrentIndex(int index){
    currentIndex=index;
    emit(ChangeCurrentIndexState());
  }

  Future<void> addBranchData({
    required String branchNo,
    required String customNo,
    required String arabicName,
    required String arabicDescription,
    required String englishName,
    required String englishDescription,
    required String note,
    required String address,
})async {
    emit(AddBranchLoadingState());
    BranchesDataModel model=BranchesDataModel(
      branch: branchNo,
      customNo: customNo,
      arabicName: arabicName,
      arabicDescription: arabicDescription,
      englishName: englishName,
      englishDescription: englishDescription,
      note: note,
      address: address,
      timestamp: Timestamp.now(),
    );
    try{
     await FirebaseFirestore.instance
          .collection('Branches')
          .doc(branchNo)
          .set(model.toMap());
      emit(AddBranchSuccessState());
      getBranchesData();
    }catch(error){
      emit(AddBranchErrorState(error.toString()));
    }
  }


  List<BranchesDataModel> allBranches=[];
  Future<void> getBranchesData()async {
    emit(GetAllBranchesLoadingState());
    try{
      QuerySnapshot<Map<String, dynamic>> querySnapshot=await FirebaseFirestore.instance
          .collection('Branches')
      .orderBy('timestamp')
          .get();
      allBranches.clear();
      for (var element in querySnapshot.docs) {
        allBranches.add(BranchesDataModel.fromJson(element.data()));
      }
      addButtonClick=false;
      currentIndex=allBranches.length-1;
      emit(GetAllBranchesSuccessState());
    }catch(error){
      emit(GetAllBranchesErrorState(error.toString()));
    }
  }


}
