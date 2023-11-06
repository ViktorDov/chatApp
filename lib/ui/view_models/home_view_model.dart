import 'package:flutter/material.dart';
import 'package:flutter_chat_app/domain/services/user_service.dart';

class MainViewModel extends ChangeNotifier {
  var userIdTitle;
  var userName;

  bool userIsCreated = false;
  final userService = UserService();

  MainViewModel() {
    _loadData();
  }

  Future<void> _loadData() async {
    await getUser();
    if (userIdTitle == "0") {
      userIsCreated = false;
      createUser();
      await getUser();
      notifyListeners();
    } else {
      userIsCreated = true;
      getUser();
      notifyListeners();
    }
  }

  Future<void> getUser() async {
    userIdTitle =
        await userService.getUserId().then((value) => value.toString());
    await getUserName();
    notifyListeners();
  }

  Future<void> getUserName() async {
    userName = await userService.getUserName();
    notifyListeners();
  }

  void delateUser() {
    userService.delateUser();
    getUser();
    notifyListeners();
  }

  Future<void> changeUserName(String name) async {
    userService.changeUserName(name);
    await getUserName();
    notifyListeners();
  }

  void createUser() {
    userService.generateUserId();
  }

  void getChatUserId(String chatUserId) {
    final id = int.parse(chatUserId);
    userService.chatUserId = id;
  }
}
