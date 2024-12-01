import 'package:flutter/material.dart';
import 'package:taskati_app/core/constnts/fonts.dart';
import 'package:taskati_app/core/utils/colors.dart';

TextStyle getTitleTextStyle(BuildContext context,{double? fontSize,Color? color,FontWeight? fontWeight}){
  return TextStyle(
    fontFamily:AppFonts.poppins,
    color: color ??Theme.of(context).colorScheme.onSurface,
    fontSize: fontSize ?? 18,
    fontWeight:fontWeight??  FontWeight.normal,

  );
}

TextStyle getBodyTextStyle(BuildContext context,{double? fontSize,Color? color,FontWeight? fontWeight}){
  return TextStyle(
    fontFamily:AppFonts.poppins,
    color: color ?? Theme.of(context).colorScheme.onSurface,
    fontSize: fontSize ?? 14,
    fontWeight:fontWeight??  FontWeight.bold,

  );
}

TextStyle getSmallTextStyle({double? fontSize,Color? color,FontWeight? fontWeight}){
  return TextStyle(
    fontFamily:AppFonts.poppins,
    color: color ?? AppColors.grayColor,
    fontSize: fontSize ?? 14,
    fontWeight:fontWeight??  FontWeight.normal,

  );
}