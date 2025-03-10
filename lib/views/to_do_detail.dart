import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/models/todo.dart';
import 'package:to_do_app/utils/constants/colors.dart';
import 'package:to_do_app/utils/constants/sizes.dart';
import 'package:to_do_app/services/to_do_sharedpref.dart';
import '../nav_bar.dart';

class ToDoDetail extends StatefulWidget {
  final ToDo todo;

  const ToDoDetail({Key? key, required this.todo}) : super(key: key);

  @override
  State<ToDoDetail> createState() => _ToDoDetailState();
}

class _ToDoDetailState extends State<ToDoDetail> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late String category;

  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.todo.todoTitle);
    _descriptionController =
        TextEditingController(text: widget.todo.todoDescription);
    category = widget.todo.todoCategory ?? 'priority';

    /// Cek jika null, kasih default DateTime.now() biar langsung kebaca di UI
    startDate = widget.todo.startDate ?? DateTime.now();
    endDate = widget.todo.endDate ?? DateTime.now();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool isStart}) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isStart ? startDate! : endDate!,
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

  String formatDate(DateTime? date) {
    if (date == null) return 'Not Set';
    return DateFormat('MMM-d-yyyy').format(date);
  }

  Future<void> deleteTodo() async {
    List<ToDo> todoList = await ToDoSharedPref.loadToDoList();

    int index = todoList.indexWhere((todo) => todo.id == widget.todo.id);

    todoList.removeAt(index);

    await ToDoSharedPref.saveToDoList(todoList);

    Get.snackbar(
      'Success',
      'Task deleted successfully!',
      backgroundColor: AppColors.primary,
      colorText: AppColors.secondary,
      margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
    );

    Get.to(() => const NavigationMenu());
  }

  Future<void> _editTodo() async {
    List<ToDo> todoList = await ToDoSharedPref.loadToDoList();

    int index = todoList.indexWhere((todo) => todo.id == widget.todo.id);

    todoList[index] = ToDo(
      id: widget.todo.id,
      todoTitle: _titleController.text.trim(),
      todoDescription: _descriptionController.text.trim(),
      todoCategory: category,
      startDate: startDate,
      endDate: endDate,
      isDone: widget.todo.isDone,
    );

    await ToDoSharedPref.saveToDoList(todoList);

    Get.snackbar(
      'Success',
      'Task updated successfully!',
      backgroundColor: AppColors.primary,
      colorText: AppColors.secondary,
      margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
    );
    Get.to(() => const NavigationMenu());
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
                      onPressed: () => Get.back(),
                    ),
                  ),
                  Text(
                    'Edit Task',
                    style: TextStyle(color: AppColors.secondary, fontSize: 20),
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.delete, color: AppColors.secondary),
                      onPressed: deleteTodo,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.defaultSpace,
                vertical: AppSizes.spaceBtwSections,
              ),
              width: double.infinity,
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
                  SizedBox(
                    width: double.infinity,
                    child: Text(_titleController.text.trim(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith()),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwSections),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Start',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: AppColors.primary)),
                      ),
                      const SizedBox(width: AppSizes.spaceBtwInputFields),
                      Expanded(
                        child: Text('End',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: AppColors.primary)),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.spaceBtwInputFields),
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
                                  formatDate(startDate),
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
                                  formatDate(endDate),
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
                    controller: _titleController,
                    style: Theme.of(context).textTheme.labelLarge,
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
                          onPressed: () =>
                              setState(() => category = 'priority'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: category == 'priority'
                                ? AppColors.primary
                                : AppColors.secondary,
                          ),
                          child: Text(
                            'Priority',
                            style: TextStyle(
                              color: category == 'priority'
                                  ? AppColors.secondary
                                  : AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSizes.spaceBtwInputFields),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => setState(() => category = 'daily'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: category == 'daily'
                                ? AppColors.primary
                                : AppColors.secondary,
                          ),
                          child: Text(
                            'Daily',
                            style: TextStyle(
                              color: category == 'daily'
                                  ? AppColors.secondary
                                  : AppColors.primary,
                            ),
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
                    controller: _descriptionController,
                    minLines: 3,
                    maxLines: null,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: AppSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _editTodo,
                      child: const Text('Edit Task'),
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
