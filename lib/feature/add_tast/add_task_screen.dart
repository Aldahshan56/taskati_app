import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati_app/core/model/task_model.dart';
import 'package:taskati_app/core/service/app_local_storage.dart';
import 'package:taskati_app/core/utils/text_style.dart';
import 'package:taskati_app/feature/home/page/home_screen.dart';

import '../../core/functions/navigation.dart';
import '../../core/utils/colors.dart';
import '../../core/widgets/custom_elevated_button.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var formKey=GlobalKey<FormState>();
  var titleController = TextEditingController();
  var noteController = TextEditingController();
  var dateController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  var startTimeController =
      TextEditingController(text: DateFormat('hh:mm a').format(DateTime.now()));
  var endTimeController =
      TextEditingController(text: DateFormat('hh:mm a').format(DateTime.now()));
  int selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_sharp,
              color: AppColors.whiteColor),
        ),
        centerTitle: true,
        title: Text(
          "Add Task",
          style: getTitleTextStyle(context,color: AppColors.whiteColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Title",
                  style: getBodyTextStyle(context),
                ),
                const Gap(5),
                TextFormField(
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter some text";
                    }
                  },
                ),
                const Gap(10),
                Text(
                  "Note",
                  style: getBodyTextStyle(context),
                ),
                const Gap(5),
                TextFormField(
                  controller: noteController,
                  validator: (value) {
                    if (value == null|| value.isEmpty) {
                      return "please enter some text";
                    }
                  },
                  maxLines: 5,
                ),
                const Gap(10),
                Text(
                  "Date",
                  style: getBodyTextStyle(context),
                ),
                const Gap(5),
                TextFormField(
                  controller: dateController,
                  readOnly: true,
                  onTap: () {
                    showDatePicker(
                            context: context,
                            firstDate: DateTime(1960),
                            initialDate: DateTime.now(),
                            lastDate: DateTime(2030))
                        .then((value) {
                      if (value != null) {
                        dateController.text =
                            DateFormat('dd/MM/yyyy').format(value);
                      }
                    });
                  },
                  decoration: const InputDecoration(
                      suffixIcon: Icon(
                    Icons.calendar_month_outlined,
                    color: AppColors.primaryColor,
                  )),
                ),
                const Gap(10),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Start Time",
                          style: getBodyTextStyle(context),
                        ),
                        TextFormField(
                          onTap: () {
                            showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                .then((value) {
                              if (value != null) {
                                startTimeController.text = value.format(context);
                              }
                            });
                          },
                          controller: startTimeController,
                          readOnly: true,
                          decoration: const InputDecoration(
                              suffixIcon: Icon(
                            Icons.access_time_outlined,
                            color: AppColors.primaryColor,
                          )),
                        )
                      ],
                    )),
                    const Gap(10),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "End Time",
                          style: getBodyTextStyle(context),
                        ),
                        TextFormField(
                          controller: endTimeController,
                          onTap: () {
                            showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                .then((value) {
                              if (value != null) {
                                endTimeController.text = value.format(context);
                              }
                            });
                          },
                          readOnly: true,
                          decoration: const InputDecoration(
                              suffixIcon: Icon(
                            Icons.access_time_outlined,
                            color: AppColors.primaryColor,
                          )),
                        )
                      ],
                    )),
                  ],
                ),
                const Gap(30),
                Row(
                    children:[
                      Row(
                        children: List.generate(3, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(3),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedColor=index;
                                });
                              },
                              child: CircleAvatar(
                                backgroundColor: index == 0
                                    ? AppColors.primaryColor
                                    : index == 1
                                    ? AppColors.orangeColor
                                    : AppColors.redColor,
                                child: (selectedColor == index)
                                    ? const Icon(
                                  Icons.check,
                                  color: AppColors.whiteColor,
                                )
                                    : const SizedBox(),
                              ),
                            ),
                          );
                        })
                      ),
                      const Spacer(),
                      CustomElevatedButton(
                        text: "Create Task",
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                            String id=DateTime.now().toString()+titleController.text;
                            AppLocalStorage.cashTaskData(id,
                                TaskModel(
                                    id:id,
                                    title: titleController.text,
                                    note: noteController.text,
                                    date: dateController.text,
                                    startTime: startTimeController.text,
                                    endTime: endTimeController.text,
                                    color: selectedColor,
                                    isCompleted: false
                                )
                            );
                            log(AppLocalStorage.getCashedTaskData(id)?.title??"null");
                            pushWithReplacement(context,const HomeScreen());
                          }

                        },
                        width: 142,
                        height: 45,
                      )
                    ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
