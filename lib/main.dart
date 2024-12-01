import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati_app/core/model/task_model.dart';
import 'package:taskati_app/feature/intro/splash_screen.dart';

import 'core/service/app_local_storage.dart';
import 'core/utils/colors.dart';
import 'core/utils/text_style.dart';
import 'core/utils/theme.dart';
Future<void>main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox("user");
  await Hive.openBox<TaskModel>("task");
  await AppLocalStorage.init();


  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable:AppLocalStorage.userBox.listenable(),
      builder: (context,value,child){
        bool isDarkMode=AppLocalStorage.getCashedData(AppLocalStorage.isDarkModeKey)??false;
        return  MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightMode,
          darkTheme:AppTheme.darkMode,
          themeMode: isDarkMode?ThemeMode.dark:ThemeMode.light,
          home: const SplashScreen(),
        );
      },
    );
  }
}
