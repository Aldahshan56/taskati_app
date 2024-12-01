import 'dart:developer';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati_app/core/functions/navigation.dart';
import 'package:taskati_app/core/model/task_model.dart';
import 'package:taskati_app/core/service/app_local_storage.dart';
import 'package:taskati_app/core/utils/colors.dart';
import 'package:taskati_app/feature/home/widgets/home_header.dart';
import 'package:taskati_app/feature/home/widgets/task_item.dart';
import 'package:taskati_app/feature/home/widgets/today_header.dart';

import '../../../core/utils/text_style.dart';
import '../../search_all_tasks/search_all_tasks.dart';
import '../../search_result_screen/search_reasult_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedDate = "";
  TextEditingController searchController = TextEditingController();
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    // Initialize the selectedDate to today's date
    selectedDate = DateFormat("dd/MM/yyyy").format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeHeader(),
                const Gap(10),
                const TodayHeader(),
                const Gap(20),
                TextField(
                  controller: searchController,
                  onChanged: (query) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    hintText: "Search for tasks",
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        pushTo(context, SearchResultsScreen(searchQuery: searchController.text));
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.primaryColor),
                    ),
                  ),
                ),
                const Gap(20),
                DatePicker(
                  DateTime.now().subtract(const Duration(days: 2)),
                  width: 80,
                  height: 100,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: AppColors.primaryColor,
                  selectedTextColor: Colors.white,
                  dateTextStyle: getBodyTextStyle(context),
                  monthTextStyle: getBodyTextStyle(context),
                  dayTextStyle: getBodyTextStyle(context),
                  onDateChange: (date) {
                    setState(() {
                      selectedDate = DateFormat("dd/MM/yyyy").format(date);
                    });
                  },
                ),
                const Gap(20),
                ValueListenableBuilder(
                  valueListenable: AppLocalStorage.taskBox.listenable(),
                  builder: (context, box, child) {
                    List<TaskModel> tasks = [];
                    for (var element in box.values) {
                      if (element.date == selectedDate &&
                          (element.title!.contains(searchController.text) ||
                              element.note!.contains(searchController.text))) {
                        tasks.add(element);
                      }
                    }

                    if (tasks.isEmpty) {
                      return Column(
                        children: [
                          Lottie.asset("assets/images/empty_state.json"),
                          Text(
                            "No Task for $selectedDate",
                            style: getBodyTextStyle(context),
                          ),
                        ],
                      );
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: UniqueKey(),
                          secondaryBackground: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: AppColors.redColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Icon(
                                  Icons.delete,
                                  color: AppColors.whiteColor,
                                ),
                                Text(
                                  "Delete",
                                  style: getBodyTextStyle(context,
                                      color: AppColors.whiteColor),
                                )
                              ],
                            ),
                          ),
                          background: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: AppColors.greenColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.check,
                                  color: AppColors.whiteColor,
                                ),
                                Text(
                                  "Complete",
                                  style: getBodyTextStyle(context,
                                      color: AppColors.whiteColor),
                                )
                              ],
                            ),
                          ),
                          onDismissed: (direction) {
                            if (direction == DismissDirection.startToEnd) {
                              box.put(
                                tasks[index].id,
                                TaskModel(
                                  id: tasks[index].id,
                                  title: tasks[index].title,
                                  note: tasks[index].note,
                                  date: tasks[index].date,
                                  startTime: tasks[index].startTime,
                                  endTime: tasks[index].endTime,
                                  color: 3,
                                  isCompleted: true,
                                ),
                              );
                              log("Complete");
                            } else {
                              box.delete(tasks[index].id);
                              log("Delete");
                            }
                          },
                          child: TaskItem(
                            taskModel: tasks[index],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Gap(10);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 20,
            right: 10,
            child: FloatingActionButton(
              heroTag: "search",
              backgroundColor: AppColors.primaryColor,
              onPressed: () {
                pushTo(context, const SearchScreen());
              },
              child: const Icon(Icons.search, size: 30, color: AppColors.whiteColor),
            ),
          ),
          Positioned(
            bottom: 80, // المسافة من الأسفل مع مراعاة وجود الزر الأول
            right: 10,
            child: FloatingActionButton(
              heroTag: "mode",
              backgroundColor: AppColors.primaryColor,
              onPressed: () {
                setState(() {
                  isDarkMode =
                      AppLocalStorage.getCashedData(AppLocalStorage.isDarkModeKey) ??
                          false;
                  AppLocalStorage.cashData(
                      AppLocalStorage.isDarkModeKey, !isDarkMode);
                });
              },
              child: Icon(
                isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
