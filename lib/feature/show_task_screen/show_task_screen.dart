import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati_app/core/utils/text_style.dart';

import '../../core/model/task_model.dart';
import '../../core/utils/colors.dart';

class ShowTaskScreen extends StatelessWidget {
  const ShowTaskScreen({super.key, required this.taskModel});
  final TaskModel taskModel;
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

      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text((taskModel.title).toString(),
                    style: getTitleTextStyle(context,
                        fontSize: 30, fontWeight: FontWeight.bold,color: AppColors.primaryColor)),
                const Gap(15),
                const Divider(
                  thickness: 1.5,
                  indent: 10,
                  endIndent: 10,
                  color: AppColors.primaryColor,
                ),
                const Gap(30),
                Text(
                  (taskModel.note).toString(),
                  style: getBodyTextStyle(context, fontSize: 20,fontWeight:FontWeight.normal),
                ),
                const Gap(30),
                const Divider(
                  thickness: 1.5,
                  indent: 10,
                  endIndent: 10,
                  color: AppColors.primaryColor,
                ),
                const Gap(30),
                Text('Date : ${(taskModel.date).toString()}'),
                const Gap(15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Start Time : ${(taskModel.startTime).toString()}'),
                    const Gap(15),
                    Text('End Time : ${(taskModel.endTime).toString()}')
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
