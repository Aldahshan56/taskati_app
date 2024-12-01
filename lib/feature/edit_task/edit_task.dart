import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati_app/core/model/task_model.dart';
import 'package:taskati_app/core/service/app_local_storage.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/text_style.dart';
import '../../core/widgets/custom_elevated_button.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({super.key, required this.taskModel});

  final TaskModel taskModel;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController noteController;
  late TextEditingController dateController;
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;
  late int selectedColor;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.taskModel.title ?? '');
    noteController = TextEditingController(text: widget.taskModel.note ?? '');
    dateController = TextEditingController(text: widget.taskModel.date ?? '');
    startTimeController = TextEditingController(text: widget.taskModel.startTime ?? '');
    endTimeController = TextEditingController(text: widget.taskModel.endTime ?? '');
    selectedColor = widget.taskModel.color ?? 0; // تعيين قيمة افتراضية
  }

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
          "Edit Task",
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
                Text("Title", style: getBodyTextStyle(context)),
                const Gap(5),
                TextFormField(
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter some text";
                    }
                  },
                ),
                const Gap(10),
                Text("Note", style: getBodyTextStyle(context)),
                const Gap(5),
                TextFormField(
                  controller: noteController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter some text";
                    }
                  },
                  maxLines: 5,
                ),
                const Gap(10),
                Text("Date", style: getBodyTextStyle(context)),
                const Gap(5),
                TextFormField(
                  controller: dateController,
                  readOnly: true,
                  onTap: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime(1960),
                      initialDate: widget.taskModel.date != null &&
                          widget.taskModel.date!.isNotEmpty
                          ? DateFormat('dd/MM/yyyy')
                          .parse(widget.taskModel.date!)
                          : DateTime.now(),
                      lastDate: DateTime(2030),
                    ).then((value) {
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
                          Text("Start Time", style: getBodyTextStyle(context)),
                          TextFormField(
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                if (value != null) {
                                  startTimeController.text =
                                      value.format(context);
                                }
                              });
                            },
                            controller: startTimeController,
                            readOnly: true,
                            decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.access_time_outlined,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("End Time", style: getBodyTextStyle(context)),
                          TextFormField(
                            controller: endTimeController,
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                if (value != null) {
                                  endTimeController.text =
                                      value.format(context);
                                }
                              });
                            },
                            readOnly: true,
                            decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.access_time_outlined,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(30),
                Row(
                  children: [
                    Row(
                      children: List.generate(3, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(3),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedColor = index;
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
                      }),
                    ),
                    const Spacer(),
                    CustomElevatedButton(
                      text: "Save Changes",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          AppLocalStorage.cashTaskData(
                            widget.taskModel.id ??"",
                            TaskModel(
                              id: widget.taskModel.id,
                              title: titleController.text,
                              note: noteController.text,
                              date: dateController.text,
                              startTime: startTimeController.text,
                              endTime: endTimeController.text,
                              color: selectedColor,
                              isCompleted: widget.taskModel.isCompleted,
                            ),
                          );
                          Navigator.pop(context);
                        }
                      },
                      width: 180,
                      height: 45,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
