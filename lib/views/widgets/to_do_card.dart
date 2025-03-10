import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/models/todo.dart';
import 'package:to_do_app/utils/constants/colors.dart';
import 'package:to_do_app/views/to_do_detail.dart';

class ToDoItems extends StatelessWidget {
  final ToDo todo;
  final Function(ToDo) onToDoChange;
  final Function() onRefresh; // Callback untuk reload todo list

  const ToDoItems({
    Key? key,
    required this.todo,
    required this.onToDoChange,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        onTap: () async {
          await Get.to(() => ToDoDetail(todo: todo));
          onRefresh();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: AppColors.accent,
            width: 1,
          ),
        ),
        tileColor: AppColors.secondary,
        title: Text(
          todo.todoTitle ?? '',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: todo.isDone ? AppColors.primary : AppColors.text,
                decoration: todo.isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
        ),
        trailing: GestureDetector(
          onTap: () {
            onToDoChange(todo);
          },
          child: Icon(
            todo.isDone
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
