import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati_app/core/functions/navigation.dart';
import 'package:taskati_app/core/service/app_local_storage.dart';
import 'package:taskati_app/core/utils/text_style.dart';
import 'package:taskati_app/feature/home/page/home_screen.dart';
import 'package:taskati_app/feature/upload/upload_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  void initState() {
    super.initState();
    bool isUpload=AppLocalStorage.getCashedData(AppLocalStorage.isUploadKey)?? false;

    Future.delayed(const Duration(seconds:3),(){
      (isUpload)?pushWithReplacement(context,const HomeScreen())
      :pushWithReplacement(context,const UploadScreen());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/images/app_logo.json"),
            const Gap(20),
            Text("Taskati",style: getTitleTextStyle(context,fontSize: 40)),
            const Gap(10),
            Text("It‘s time to get organized!",style:getSmallTextStyle())
          ],
        ),
      )
    );
  }
}
