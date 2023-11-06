import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class UserDataProvider {
  final _sharedPreferences = SharedPreferences.getInstance();

  Future<int> getUserId() async {
    final user = (await _sharedPreferences).getInt('userId') ?? 0;
    return user;
  }

  Future<String> getUserName() async {
    final user =
        (await _sharedPreferences).getString('userName') ?? 'Incognito';
    return user;
  }

  Future<void> saveUserId(User user) async {
    (await _sharedPreferences).setInt('userId', user.id);
  }

  Future<void> saveUserName(User user) async {
    (await _sharedPreferences).setString('userName', user.name);
  }

  Future<void> delateUserId() async {
    (await _sharedPreferences).clear();
  }
}
