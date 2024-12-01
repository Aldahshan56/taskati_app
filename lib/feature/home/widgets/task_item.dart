import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati_app/core/functions/navigation.dart';
import 'package:taskati_app/core/functions/show_dialogs.dart';
import 'package:taskati_app/core/model/task_model.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/text_style.dart';
import '../../edit_task/edit_task.dart';
class TaskItem extends StatelessWidget {
  const TaskItem({super.key,required this.taskModel});
  final TaskModel taskModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        taskOperation(context,taskModel);
        //pushTo(context, EditTaskScreen(taskModel:taskModel));
      },
      child: Container(
        margin:const EdgeInsets.symmetric(horizontal: 5) ,
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        //height: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: taskModel.color==3?AppColors.greenColor:taskModel.color==0?AppColors.primaryColor:taskModel.color==1?AppColors.orangeColor:AppColors.redColor
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskModel.title??"",
                    style: getTitleTextStyle(
                        context,
                        color: AppColors.whiteColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(5),
                  Row(
                    children: [
                      const Icon(
                        Icons.watch_later_outlined,
                        size: 20,
                        color: AppColors.whiteColor,
                      ),
                      const Gap(4),
                      Text("${taskModel.startTime} - ${taskModel.endTime}",
                          style: getTitleTextStyle(
                              context,
                              color: AppColors.whiteColor,
                              fontSize: 15),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                  const Gap(5),
                  Text(
                    taskModel.note??"",
                    style: getTitleTextStyle(
                        context,
                        color: AppColors.whiteColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                ],
              ),
            ),
            const Gap(5),
            Container(
              width: 1,
              height: 70,
              color: AppColors.whiteColor,
            ),
            const Gap(5),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                (taskModel.isCompleted??false)?"COMPLETED":"TODO",
                style:getSmallTextStyle(color: AppColors.whiteColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
