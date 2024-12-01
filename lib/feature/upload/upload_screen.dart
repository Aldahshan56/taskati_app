import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati_app/core/functions/dialogs.dart';
import 'package:taskati_app/core/functions/navigation.dart';
import 'package:taskati_app/core/service/app_local_storage.dart';
import 'package:taskati_app/core/utils/colors.dart';
import 'package:taskati_app/core/utils/text_style.dart';
import 'package:taskati_app/core/widgets/custom_elevated_button.dart';
import 'package:taskati_app/feature/home/page/home_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String? path;
  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                if (path == null && name.isEmpty) {
                  showErrorDialog(context,"Please upload your image and enter your name");
                } else if (path == null && name.isNotEmpty) {
                  showErrorDialog(context,"Please upload your image");
                } else if (path != null && name.isEmpty) {
                  showErrorDialog(context,"Please enter your name");
                } else {
                  //showRightDialog(context,"Welcome $name");
                  AppLocalStorage.cashData(AppLocalStorage.nameKey,name);
                  AppLocalStorage.cashData(AppLocalStorage.imageKey, path!);
                  AppLocalStorage.cashData(AppLocalStorage.isUploadKey,true);
                  pushWithReplacement(context, const HomeScreen());
                }
              },
              child: Text(
                "Done",
                style: getBodyTextStyle(
                    context,
                    color: AppColors.whiteColor, fontSize: 20),
              ))
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 101,
                backgroundColor: AppColors.primaryColor,
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: AppColors.primaryColor,
                  backgroundImage: path != null
                      ? FileImage(File(path!))
                      : const AssetImage("assets/images/user.png") as ImageProvider,
                  //path!=null?AssetImage(path!):const AssetImage("assets/images/profile_account.png"),
                ),
              ),
              const Gap(30),
              CustomElevatedButton(
                onPressed: () async {
                  await uploadImage(isCamera: true);
                },
                text: "Upload from Camera",
              ),
              const Gap(10),
              CustomElevatedButton(
                  onPressed: () async {
                    await uploadImage(isCamera: false);
                  },
                  text: "Upload from Gallery"),
              const Gap(30),
              const Divider(
                thickness: 1.5,
                indent: 10,
                endIndent: 10,
                color: AppColors.primaryColor,
              ),
              //const Gap(20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  style: getSmallTextStyle(
                      color: AppColors.darkColor, fontSize: 20),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      size: 30,
                    ),
                    prefixIconColor: AppColors.grayColor,
                    hintText: "Please enter your Name",
                    label: Text("User Name"),

                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  uploadImage({required bool isCamera}) async {
    await ImagePicker()
        .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery)
        .then((value) {
      if (value != null) {
        setState(() {
          path = value.path;
        });
      }
    });
  }
}
