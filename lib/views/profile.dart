import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/services/user_sharedpref.dart';
import 'package:to_do_app/models/user.dart';
import 'package:to_do_app/utils/constants/colors.dart';
import 'package:to_do_app/utils/constants/sizes.dart';
import 'package:to_do_app/utils/styles/spacing_styles.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _majorController = TextEditingController();
  final _emailController = TextEditingController();

  DateTime? _dob;
  UserModel? _user;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _majorController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final userController = UserController();
    final user = await userController.getUser();

    setState(() {
      _user = user ??
          UserModel(
            name: '',
            dob: DateTime.now(),
            major: '',
            email: '',
          );

      _nameController.text = _user!.name;
      _majorController.text = _user!.major;
      _emailController.text = _user!.email;
      _dob = _user!.dob;
    });
  }

  String formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('MMM-d-yyyy').format(date);
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _dob ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
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
      setState(() => _dob = pickedDate);
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final userController = UserController();
      await userController.updateUserField(photoPath: pickedFile.path);

      setState(() {
        _user = _user?.copyWith(photoPath: pickedFile.path);
      });
    }
  }

  Future<void> _saveUser() async {
    if (_formKey.currentState!.validate()) {
      final userController = UserController();

      final updatedUser = _user?.copyWith(
        name: _nameController.text.trim(),
        dob: _dob ?? DateTime.now(),
        major: _majorController.text.trim(),
        email: _emailController.text.trim(),
      );

      if (updatedUser != null) {
        await userController.saveUser(updatedUser);
        setState(() {
          _user = updatedUser;
        });

        Get.snackbar(
          'Success',
          'User updated successfully!',
          backgroundColor: AppColors.primary,
          colorText: AppColors.secondary,
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: AppSpacingStyle.profilePadding,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.primary,
                      backgroundImage: (_user?.photoPath != null &&
                              _user!.photoPath!.isNotEmpty)
                          ? (kIsWeb
                              ? NetworkImage(_user!.photoPath!)
                                  as ImageProvider<Object>
                              : FileImage(File(_user!.photoPath!))
                                  as ImageProvider<Object>)
                          : null,
                      child: (_user?.photoPath == null ||
                              _user!.photoPath!.isEmpty)
                          ? const Icon(Icons.person,
                              size: 50, color: Colors.white)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors
                              .primary, // Background putih biar kontras
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt, // Bisa ganti jadi Icons.edit juga
                          size: 20,
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Username',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.primary,
                        ),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwInputFields),
                  TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    style: Theme.of(context).textTheme.labelLarge,
                    decoration: const InputDecoration(
                      hintText: 'Enter your name',
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter your name'
                        : null,
                  ),
                  const SizedBox(height: AppSizes.spaceBtwSections),
                  Text(
                    'Major',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.primary,
                        ),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwInputFields),
                  TextFormField(
                    controller: _majorController,
                    keyboardType: TextInputType.text,
                    style: Theme.of(context).textTheme.labelLarge,
                    decoration: const InputDecoration(
                      hintText: 'Enter your major',
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter your major'
                        : null,
                  ),
                  const SizedBox(height: AppSizes.spaceBtwSections),
                  Text(
                    'Date of Birth',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.primary,
                        ),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwInputFields),
                  SizedBox(
                    width: double.infinity,
                    height: AppSizes.buttonHeight * 2,
                    child: GestureDetector(
                      onTap: _pickDate,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.accent, width: 1),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today,
                                color: AppColors.primary, size: 20),
                            const SizedBox(width: 8),
                            SizedBox(width: AppSizes.spaceBtwInputFields),
                            Text(
                              _dob != null ? formatDate(_dob) : '',
                              style: TextStyle(
                                color: AppColors.text,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwSections),
                  Text(
                    'Email',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.primary,
                        ),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwInputFields),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: Theme.of(context).textTheme.labelLarge,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter your email'
                        : null,
                  ),
                  const SizedBox(height: AppSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _saveUser,
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
