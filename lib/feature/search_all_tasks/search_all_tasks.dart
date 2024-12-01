import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati_app/core/utils/text_style.dart';
import '../../core/model/task_model.dart';
import '../../core/service/app_local_storage.dart';
import '../home/widgets/task_item.dart';
import '../../../core/utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<TaskModel> filteredTasks = [];
  void _filterTasks(String query) {
    final box = AppLocalStorage.taskBox;

    setState(() {
      if (query.isEmpty) {
        filteredTasks = [];
      } else {
        filteredTasks = box.values.where((task) {
          return task.title!.toLowerCase().contains(query.toLowerCase()) ||
              task.note!.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    filteredTasks.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new,color: AppColors.whiteColor,)
        ),
        centerTitle: true,
        title: Text('Search Tasks',style:getTitleTextStyle(context,color:AppColors.whiteColor),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: (query) {
                _filterTasks(query);
              },
              decoration: InputDecoration(
                hintText: 'Search for tasks...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: filteredTasks.isEmpty
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset("assets/images/empty_state.json"),
                  const Gap(10),
                  Text("No tasks found.",style: getBodyTextStyle(context),),
                ],
              )
                  : ListView.separated(
                itemCount: filteredTasks.length,
                itemBuilder: (context, index) {
                  return TaskItem(taskModel: filteredTasks[index]);
                },
                separatorBuilder: (context, index) {
                  return const Gap(10);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
