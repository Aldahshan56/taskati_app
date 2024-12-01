import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../core/model/task_model.dart';
import '../../core/service/app_local_storage.dart';
import '../../core/utils/text_style.dart';
import '../home/widgets/task_item.dart';
class SearchResultsScreen extends StatelessWidget {
  final String searchQuery;
  const SearchResultsScreen({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Results"),
      ),
      body: ValueListenableBuilder(
        valueListenable: AppLocalStorage.taskBox.listenable(),
        builder: (context, box, child) {
          List<TaskModel> tasks = [];
          for (var element in box.values) {
            if (element.title!.contains(searchQuery) || element.note!.contains(searchQuery)) {
              tasks.add(element);
            }
          }

          if (tasks.isEmpty) {
            return Column(
              children: [
                Lottie.asset("assets/images/empty_state.json"),
                Text(
                  "No matching tasks found for '$searchQuery'",
                  style: getBodyTextStyle(context),
                )
              ],
            );
          }

          return ListView.separated(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return TaskItem(taskModel: tasks[index]);
            },
            separatorBuilder: (context, index) {
              return const Gap(10);
            },
          );
        },
      ),
    );
  }
}
