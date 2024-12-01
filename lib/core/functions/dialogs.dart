import 'package:flutter/material.dart';
import 'package:taskati_app/core/utils/text_style.dart';
import '../utils/colors.dart';
showErrorDialog(BuildContext context,String text){
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(
      backgroundColor: AppColors.redColor,
      content:Text(text,style: getBodyTextStyle(context,color: AppColors.whiteColor),)
  ));
}
/*
showRightDialog(BuildContext context,String text){
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(
      backgroundColor: AppColors.greenColor,
      content:Text(text,style: getBodyTextStyle(color: AppColors.whiteColor),)
  ));
}
 */