import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import 'dart:convert';

class UserController {
  static const String _userKey = 'userProfile';
  static final UserController _instance = UserController._internal();

  factory UserController() => _instance;

  UserController._internal();

  Future<void> saveUser(UserModel user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = jsonEncode(user.toJson());
      await prefs.setString(_userKey, userJson);
    } catch (e) {
      print('Error saving user: $e');
    }
  }

  Future<UserModel?> getUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_userKey);

      if (userJson != null) {
        final Map<String, dynamic> userMap = jsonDecode(userJson);
        return UserModel.fromJson(userMap);
      }
      return null;
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }

  Future<void> clearUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userKey);
    } catch (e) {
      print('Error clearing user: $e');
    }
  }

  Future<void> updateUserField({
    String? name,
    DateTime? dob,
    String? major,
    String? email,
    String? photoPath,
  }) async {
    try {
      final currentUser = await getUser() ??
          UserModel(
            name: '',
            dob: DateTime.now(),
            major: '',
            email: '',
          );

      final updatedUser = currentUser.copyWith(
        name: name,
        dob: dob,
        major: major,
        email: email,
        photoPath: photoPath,
      );

      await saveUser(updatedUser);
    } catch (e) {
      print('Error updating user field: $e');
    }
  }

  Future<String?> getUserPhotoPath() async {
    final user = await getUser();
    return user?.photoPath;
  }
}
