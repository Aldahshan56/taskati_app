import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/text_style.dart';
class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.width=300,
    this.height=55,
    this.textColor,
    this.backGroundColor,
    required this.text,
    required this.onPressed
  });
  final double width;
  final double height;
  final Color? textColor;
  final Color? backGroundColor;
  final String text;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child:ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor:backGroundColor??AppColors.primaryColor
          ),
          onPressed:onPressed,
          child:Text(
            text,
            style:getBodyTextStyle(context,color: AppColors.whiteColor) ,
          )
      ),
    );
  }
}
