import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:to_do_app/models/todo.dart';
import 'package:to_do_app/utils/constants/colors.dart';
import 'package:to_do_app/utils/constants/sizes.dart';
import 'package:to_do_app/services/to_do_sharedpref.dart';
import '../nav_bar.dart';

class ToDoAdd extends StatefulWidget {
  const ToDoAdd({Key? key}) : super(key: key);

  @override
  State<ToDoAdd> createState() => _ToDoAddState();
}

class _ToDoAddState extends State<ToDoAdd> {
  List<ToDo> todoList = [];
  String category = 'priority';
  final toDoTitle = TextEditingController();
  final toDoDescription = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  String formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('MMM-d-yyyy').format(date);
  }

  Future<void> _toDoAddItem(String title, String description) async {
    final newTodo = ToDo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      todoTitle: title,
      todoCategory: category,
      todoDescription: description,
      isDone: false,
      startDate: startDate,
      endDate: endDate,
    );

    final list = await ToDoSharedPref.loadToDoList();
    list.add(newTodo);
    await ToDoSharedPref.saveToDoList(list);

    toDoTitle.clear();
    toDoDescription.clear();

    Get.snackbar('Success', 'Task added successfully!',
        backgroundColor: AppColors.primary,
        colorText: AppColors.secondary,
        margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20));

    Get.to(const NavigationMenu());
  }

  Future<void> _pickDate({
    required bool isStart,
  }) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(2000);
    DateTime lastDate = DateTime(2100);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate:
          isStart ? (startDate ?? DateTime.now()) : (endDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.secondary,
              onSurface: AppColors.text,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        if (isStart) {
          startDate = pickedDate;
          if (endDate != null && startDate!.isAfter(endDate!)) {
            final temp = startDate;
            startDate = endDate;
            endDate = temp;
          }
        } else {
          endDate = pickedDate;
          if (startDate != null && endDate!.isBefore(startDate!)) {
            final temp = endDate;
            endDate = startDate;
            startDate = temp;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  top: 50, left: 25, right: 25, bottom: 40),
              width: double.infinity,
              color: AppColors.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: AppColors.primary),
                      onPressed: () => Get.to(() => const NavigationMenu()),
                    ),
                  ),
                  Text(
                    'Add Task',
                    style: TextStyle(color: AppColors.secondary, fontSize: 20),
                  ),
                  const SizedBox(width: 24),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.defaultSpace,
                  vertical: AppSizes.spaceBtwSections),
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    120, // Minimum setinggi layar
              ),
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text('Start',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: AppColors.primary)),
                      ),
                      const SizedBox(
                        width: AppSizes.spaceBtwInputFields,
                      ),
                      Expanded(
                        child: Text('End',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: AppColors.primary)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSizes.spaceBtwInputFields,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _pickDate(isStart: true),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 12),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: AppColors.primary, width: 1),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today,
                                    color: AppColors.primary, size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  startDate != null
                                      ? formatDate(startDate)
                                      : 'Select Start',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSizes.spaceBtwInputFields),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _pickDate(isStart: false),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: AppColors.primary, width: 1),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today,
                                    color: AppColors.primary, size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  endDate != null
                                      ? formatDate(endDate)
                                      : 'Select End',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.spaceBtwSections),
                  Text('Title',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: AppColors.primary)),
                  const SizedBox(height: AppSizes.spaceBtwInputFields),
                  TextFormField(
                    controller: toDoTitle,
                    style: Theme.of(context).textTheme.labelLarge,
                    decoration: const InputDecoration(
                      hintText: 'Enter task Title here!',
                    ),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwSections),
                  Text('Category',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: AppColors.primary)),
                  const SizedBox(height: AppSizes.spaceBtwInputFields),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              category = 'priority';
                            });
                          },
                          child: Text('Priority Task',
                              style: TextStyle(
                                color: category == 'priority'
                                    ? AppColors.secondary
                                    : AppColors.primary,
                              )),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: category == 'priority'
                                ? AppColors.primary
                                : AppColors.secondary,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSizes.spaceBtwInputFields),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              category = 'daily';
                            });
                          },
                          child: Text('Daily Task',
                              style: TextStyle(
                                color: category == 'daily'
                                    ? AppColors.secondary
                                    : AppColors.primary,
                              )),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: category == 'daily'
                                ? AppColors.primary
                                : AppColors.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.spaceBtwSections),
                  Text('Description',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: AppColors.primary)),
                  const SizedBox(height: AppSizes.spaceBtwInputFields),
                  TextFormField(
                    controller: toDoDescription,
                    minLines: 5,
                    maxLines: null,
                    style: Theme.of(context).textTheme.labelLarge,
                    decoration: const InputDecoration(
                      hintText: 'Enter task Description here!',
                    ),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _toDoAddItem(
                          toDoTitle.text.trim(),
                          toDoDescription.text.trim(),
                        );
                      },
                      child: const Text('Add Task'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
