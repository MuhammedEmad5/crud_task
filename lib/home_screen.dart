import 'dart:math';
import 'package:crud_task/cubit/cubit.dart';
import 'package:crud_task/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController branchController =
      TextEditingController(text: '0');
  final TextEditingController customNoController = TextEditingController();
  final TextEditingController arabicNameController = TextEditingController();
  final TextEditingController englishNameController = TextEditingController();
  final TextEditingController arabicDescriptionController =
      TextEditingController();
  final TextEditingController englishDescriptionController =
      TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeScreenCubit()..getBranchesData(),
      child: BlocConsumer<HomeScreenCubit, HomeScreenStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          HomeScreenCubit cubit = HomeScreenCubit.get(context);
          if (cubit.allBranches.isNotEmpty && !cubit.addButtonClick) {
            if (cubit.currentIndex >= 0 &&
                cubit.currentIndex < cubit.allBranches.length) {
              branchController.text =
                  cubit.allBranches[cubit.currentIndex].branch.toString();
              customNoController.text =
                  cubit.allBranches[cubit.currentIndex].customNo ?? '';
              arabicNameController.text =
                  cubit.allBranches[cubit.currentIndex].arabicName ?? '';
              arabicDescriptionController.text =
                  cubit.allBranches[cubit.currentIndex].arabicDescription ?? '';
              englishNameController.text =
                  cubit.allBranches[cubit.currentIndex].englishName ?? '';
              englishDescriptionController.text =
                  cubit.allBranches[cubit.currentIndex].englishDescription ??
                      '';
              noteController.text =
                  cubit.allBranches[cubit.currentIndex].note ?? '';
              addressController.text =
                  cubit.allBranches[cubit.currentIndex].address ?? '';
            }
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Branch / store / cashier',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              centerTitle: true,
              actions: [
                addIconButton(cubit),
                state is AddBranchLoadingState
                    ? const CircularProgressIndicator()
                    : saveIconButton(cubit),
              ],
              backgroundColor: Colors.indigo,
            ),
            body: state is GetAllBranchesLoadingState
                ? const Center(child: CircularProgressIndicator())
                : cubit.allBranches.isEmpty && !cubit.addButtonClick
                    ? const Center(child: Text('no data yet'))
                    : LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          if (constraints.maxWidth > 580) {
                            return largeScreenWidget(cubit);
                          }
                          return smallScreenWidget(cubit);
                        },
                      ),
          );
        },
      ),
    );
  }

  Widget saveIconButton(HomeScreenCubit cubit) {
    return IconButton(
        onPressed: () async {
          if (cubit.addButtonClick) {
            branchController.text = generateRandomBranch().toString();
          }
          if (formKey.currentState!.validate()) {
            await cubit.addBranchData(
              branchNo: branchController.text,
              customNo: customNoController.text,
              arabicName: arabicNameController.text,
              arabicDescription: arabicDescriptionController.text,
              englishName: englishNameController.text,
              englishDescription: englishDescriptionController.text,
              note: noteController.text,
              address: addressController.text,
            );
            clearFields();
          }
        },
        icon: const Icon(
          Icons.save,
          color: Colors.white,
        ));
  }

  Widget addIconButton(HomeScreenCubit cubit) {
    return IconButton(
        onPressed: () {
          cubit.clickAddButton();
          if (cubit.addButtonClick) {
            clearFields();
          }
        },
        icon: Icon(
          cubit.addButtonClick ? Icons.cancel : Icons.add_circle_outlined,
          color: Colors.white,
        ));
  }

  int generateRandomBranch() {
    Random random = Random();
    return random.nextInt(900000) + 100000;
  }

  Widget defaultFormField(
      {required String fieldName,
      required TextEditingController controller,
      int maxLine = 1,
      bool readOnly = false,
      bool isArabicText = false,
      dynamic keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(fieldName),
        TextFormField(
          controller: controller,
          maxLines: maxLine,
          validator: (value) {
            if (value!.isEmpty) {
              return '$fieldName can\'t be Empty';
            }
            return null;
          },
          keyboardType: keyboardType,
          textDirection: isArabicText ? TextDirection.rtl : TextDirection.ltr,
          readOnly: readOnly,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.indigo),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }

  Widget navigationButtons(HomeScreenCubit cubit) {
    int totalBranches = cubit.allBranches.length;
    int currentIndex = cubit.currentIndex;
    if (cubit.addButtonClick) {
      totalBranches++;
      currentIndex = cubit.allBranches.length;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              cubit.changeCurrentIndex(0);
            },
            icon: Icon(
              Icons.skip_previous,
              color: cubit.currentIndex==0?Colors.indigo.withOpacity(0.4) : Colors.indigo,
            )),
        IconButton(
            onPressed: () {
              if (cubit.currentIndex > 0) {
                cubit.changeCurrentIndex(cubit.currentIndex - 1);
              }
            },
            icon: Icon(
              Icons.arrow_left_rounded,
              size: 40,
              color: cubit.currentIndex==0?Colors.indigo.withOpacity(0.4) : Colors.indigo,
            )),
        Text(
          totalBranches == 0 ? '0/0' : '${currentIndex + 1}/$totalBranches',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.indigo,
          ),
        ),
        IconButton(
            onPressed: () {
              if (cubit.currentIndex < cubit.allBranches.length - 1) {
                cubit.changeCurrentIndex(cubit.currentIndex + 1);
              }
            },
            icon: Icon(
              Icons.arrow_right_rounded,
              size: 40,
              color: cubit.currentIndex==totalBranches-1?Colors.indigo.withOpacity(0.4) : Colors.indigo,
            )),
        IconButton(
            onPressed: () {
              cubit.changeCurrentIndex(cubit.allBranches.length - 1);
            },
            icon: Icon(
              Icons.skip_next,
              color: cubit.currentIndex==totalBranches-1?Colors.indigo.withOpacity(0.4) : Colors.indigo,
            )),
      ],
    );
  }

  void clearFields() {
    branchController.text = '0';
    customNoController.clear();
    arabicNameController.clear();
    arabicDescriptionController.clear();
    englishNameController.clear();
    englishDescriptionController.clear();
    noteController.clear();
    addressController.clear();
  }

  Widget smallScreenWidget(cubit) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                            flex: 2,
                            child: defaultFormField(
                                fieldName: 'branch',
                                readOnly: true,
                                controller: branchController)),
                        const SizedBox(width: 8),
                        Expanded(
                            flex: 1,
                            child: defaultFormField(
                                fieldName: 'custom No.',
                                keyboardType: TextInputType.number,
                                controller: customNoController)),
                      ],
                    ),
                    const SizedBox(height: 25),
                    defaultFormField(
                        fieldName: 'Arabic Name',
                        isArabicText: true,
                        controller: arabicNameController),
                    const SizedBox(height: 25),
                    defaultFormField(
                        fieldName: 'Arabic Description',
                        isArabicText: true,
                        controller: arabicDescriptionController),
                    const SizedBox(height: 25),
                    defaultFormField(
                        fieldName: 'English Name',
                        controller: englishNameController),
                    const SizedBox(height: 25),
                    defaultFormField(
                        fieldName: 'English Description',
                        controller: englishDescriptionController),
                    const SizedBox(height: 25),
                    defaultFormField(
                        fieldName: 'Note',
                        controller: noteController,
                        maxLine: 3),
                    const SizedBox(height: 25),
                    defaultFormField(
                        fieldName: 'Address',
                        controller: addressController,
                        maxLine: 3),
                  ],
                ),
              ),
            ),
          ),
          navigationButtons(cubit),
        ],
      ),
    );
  }

  Widget largeScreenWidget(cubit) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                            child: defaultFormField(
                                fieldName: 'branch',
                                readOnly: true,
                                controller: branchController)),
                        const SizedBox(width: 15),
                        Expanded(
                            child: defaultFormField(
                                fieldName: 'custom No.',
                                keyboardType: TextInputType.number,
                                controller: customNoController)),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Expanded(
                          child: defaultFormField(
                              fieldName: 'Arabic Name',
                              controller: arabicNameController),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: defaultFormField(
                              fieldName: 'Arabic Description',
                              controller: arabicDescriptionController),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Expanded(
                          child: defaultFormField(
                              fieldName: 'English Name',
                              controller: englishNameController),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: defaultFormField(
                              fieldName: 'English Description',
                              controller: englishDescriptionController),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Expanded(
                          child: defaultFormField(
                              fieldName: 'Note',
                              controller: noteController,
                              maxLine: 3),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: defaultFormField(
                              fieldName: 'Address',
                              controller: addressController,
                              maxLine: 3),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          navigationButtons(cubit),
        ],
      ),
    );
  }
}
