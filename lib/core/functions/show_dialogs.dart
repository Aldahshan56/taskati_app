import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati_app/feature/show_task_screen/show_task_screen.dart';
import '../../feature/edit_task/edit_task.dart';
import '../model/task_model.dart';
import '../widgets/custom_elevated_button.dart';
import 'navigation.dart';

void taskOperation(BuildContext context,TaskModel taskModel) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomElevatedButton(
                  text: "edit",
                  onPressed: () {
                    Navigator.of(context).pop();
                    pushTo(context, EditTaskScreen(taskModel:taskModel,));
                  },
                  width: 130,
                  height: 45,
                ),
                const Gap(15),
                CustomElevatedButton(
                  text: "Show",
                  onPressed: () {
                    Navigator.of(context).pop();
                    pushTo(context, ShowTaskScreen(taskModel:taskModel,));

                  },
                  width: 130,
                  height: 45,
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
