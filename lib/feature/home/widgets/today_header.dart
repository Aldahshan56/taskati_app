import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskati_app/core/functions/navigation.dart';
import 'package:taskati_app/core/service/app_local_storage.dart';
import 'package:taskati_app/core/widgets/custom_elevated_button.dart';
import 'package:taskati_app/feature/add_tast/add_task_screen.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/text_style.dart';
class TodayHeader extends StatelessWidget {
  const TodayHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              //DateTime.now().toIso8601String()
              //DateFormat("dd/MMM/yyyy").format(DateTime.now()),
              DateFormat.yMMMMd().format(DateTime.now()),
              style:getBodyTextStyle(context,color: AppColors.primaryColor,fontSize: 14),
            ),
            Text(
              "Today",
              style:getSmallTextStyle(fontSize: 18),
            ),
          ],
        ),
        const Spacer(),
        CustomElevatedButton(
            text: "+Add Task",
            onPressed: (){
              pushTo(context,const AddTaskScreen());
            },
          width: 130,
          height: 45,
        )
      ],
    );
  }
}
