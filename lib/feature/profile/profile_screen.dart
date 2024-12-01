import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati_app/core/service/app_local_storage.dart';
import 'package:taskati_app/core/utils/colors.dart';
import 'package:taskati_app/core/widgets/custom_elevated_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var nameController = TextEditingController(
      text: AppLocalStorage.getCashedData(AppLocalStorage.nameKey));
  var editNameController = TextEditingController(
      text: AppLocalStorage.getCashedData(AppLocalStorage.nameKey));
  String? path;
  String name = "";
  bool isDarkMode=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.whiteColor,
            )),
        actions: [
          IconButton(
              onPressed: () {
                isDarkMode=AppLocalStorage.getCashedData(AppLocalStorage.isDarkModeKey)??false;
                AppLocalStorage.cashData(AppLocalStorage.isDarkModeKey,!isDarkMode);
              },
              icon:Icon(
                 isDarkMode?Icons.dark_mode:Icons.light_mode,
                color: AppColors.whiteColor,
              )),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: AppColors.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomElevatedButton(
                              width: double.infinity,
                              onPressed: () async {
                                await uploadImage(isCamera: true);
                              },
                              text: "Upload from Camera",
                            ),
                            const Gap(10),
                            CustomElevatedButton(
                              width: double.infinity,
                              onPressed: () async {
                                await uploadImage(isCamera: false);
                              },
                              text: "Upload from Gallery",
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: CircleAvatar(
                  radius: 101,
                  backgroundColor: AppColors.primaryColor,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundColor: AppColors.primaryColor,
                        backgroundImage: FileImage(File(
                            AppLocalStorage.getCashedData(
                                AppLocalStorage.imageKey))),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 50,
                          width: 33,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(30),
              const Divider(
                thickness: 1.5,
                indent: 10,
                endIndent: 10,
                color: AppColors.primaryColor,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Theme.of(context).colorScheme.onSecondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                            top: 16.0,
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: editNameController,
                                onChanged: (value) {
                                  setState(() {
                                    name = value;
                                  });
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const Gap(10),
                              CustomElevatedButton(
                                width: double.infinity,
                                onPressed: () {
                                  AppLocalStorage.cashData(
                                      AppLocalStorage.nameKey, name);
                                  setState(() {
                                    nameController.text = name;
                                  });
                                  Navigator.pop(context);
                                },
                                text: "Edit Name",
                              ),
                              const Gap(10),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  controller: nameController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(
                      Icons.edit,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
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
          AppLocalStorage.cashData(AppLocalStorage.imageKey, value.path);
        });
        Navigator.pop(context);
      }
    });
  }
}
