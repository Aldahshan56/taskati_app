import 'package:hive/hive.dart';
import 'package:taskati_app/core/model/task_model.dart';

class AppLocalStorage{
  static late Box userBox;
  static late Box <TaskModel>taskBox;
  static String nameKey="name";
  static String imageKey="image";
  static String isUploadKey="isUpload";
  static String isDarkModeKey="isDarkMode";
  static init(){
    userBox=Hive.box("user");
    taskBox=Hive.box<TaskModel>("task");
  }
  static cashData(String key,dynamic value){
    userBox.put(key, value);
  }
  static getCashedData(String key){
    return userBox.get(key);
  }

  static cashTaskData(String key,TaskModel value){
    taskBox.put(key, value);
  }
  static TaskModel? getCashedTaskData(String key){
    return taskBox.get(key);
  }

}