import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/models/todo.dart';
import 'package:to_do_app/models/user.dart';
import 'package:to_do_app/utils/styles/spacing_styles.dart';
import 'package:to_do_app/utils/constants/text_strings.dart';
import 'package:to_do_app/utils/constants/sizes.dart';
import 'package:to_do_app/utils/constants/colors.dart';
import 'package:to_do_app/views/to_do_add.dart';
import 'package:to_do_app/views/widgets/to_do_card.dart';
import 'package:to_do_app/services/to_do_sharedpref.dart';
import 'package:to_do_app/services/user_sharedpref.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ToDo> todoList = [];
  UserModel? _user;
  final UserController _userController = UserController();

  final String formattedDate =
      DateFormat('EEEE, MMM d yyyy').format(DateTime.now());
  @override
  void initState() {
    super.initState();
    loadTodoList();
    loadUser();
  }

  Future<void> loadTodoList() async {
    final list = await ToDoSharedPref.loadToDoList();
    setState(() {
      todoList = list;
    });
  }

  Future<void> loadUser() async {
    final user = await _userController.getUser();
    setState(() {
      _user = user;
    });
  }

  Future<void> _handleToDoChange(ToDo todo) async {
    setState(() {
      todo.isDone = !todo.isDone;
    });
    await ToDoSharedPref.saveToDoList(todoList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: AppSpacingStyle.defaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formattedDate,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: AppSizes.spaceBtwSections + 10),
                Text(
                  'Welcome ${_user?.name ?? 'User'}',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: AppColors.text,
                      ),
                ),
                const SizedBox(height: AppSizes.dividerHeight),
                Text(
                  AppTexts.homeSubtitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: AppSizes.spaceBtwSections),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppTexts.homeFill,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: AppColors.text),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await Get.to(() => const ToDoAdd());
                        loadTodoList(); // Refresh after adding new todo
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text('Add Task'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
                todoList.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 75),
                          child: Text(
                            "YEY! No Tasks Yet",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: AppColors.text),
                          ),
                        ),
                      )
                    : Column(
                        children: todoList
                            .map(
                              (todo) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                child: ToDoItems(
                                  todo: todo,
                                  onToDoChange: _handleToDoChange,
                                  onRefresh:
                                      loadTodoList, // ini buat refresh setelah dari detail
                                ),
                              ),
                            )
                            .toList(),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
