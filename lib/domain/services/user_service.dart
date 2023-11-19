import 'dart:math';

import '../data_provider/user_data_provider.dart';
import '../entity/user.dart';

class UserService {
  final userDataProvider = UserDataProvider();
  var _user = User('Name', 0);
  User get user => _user;
  var chatUserId = 1;

  void generateUserId() {
    Random random = Random();
    final randomNumber = random.nextInt(9999) + 1;
    _user = _user.copyWith(id: randomNumber);
    userDataProvider.saveUserId(_user);
  }

  void delateUser() {
    userDataProvider.delateUserId();
  }

  void changeUserName(String name) {
    _user = _user.copyWith(name: name);
    userDataProvider.saveUserName(_user);
  }

  Future<int> getUserId() async {
    var requestUserId = await userDataProvider.getUserId();
    return requestUserId;
  }

  Future<String> getUserName() async {
    var requestUserName = await userDataProvider.getUserName();
    return requestUserName;
  }
}
