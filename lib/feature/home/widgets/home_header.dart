import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati_app/core/functions/navigation.dart';
import 'package:taskati_app/core/service/app_local_storage.dart';
import 'package:taskati_app/feature/profile/profile_screen.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/text_style.dart';
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable:AppLocalStorage.userBox.listenable(),
      builder: (context,value,child){
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello,${AppLocalStorage.getCashedData(AppLocalStorage.nameKey)}",
                  style:getBodyTextStyle(context,color: AppColors.primaryColor,fontSize: 16),
                ),
                Text(
                  "have a Nice Day!",
                  style:getSmallTextStyle(),
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: (){
                pushTo(context,const ProfileScreen());
              },
              child: CircleAvatar(
                  radius: 30,
                  backgroundImage: FileImage(File(AppLocalStorage.getCashedData(AppLocalStorage.imageKey)))
              ),
            )
          ],
        );
      }
    );
  }
}
