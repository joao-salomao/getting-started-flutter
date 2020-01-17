import 'dart:async';

import 'package:getting_started/entities/user.dart';
import 'package:getting_started/utils/api.dart';

class LoginBloc {
  final StreamController _streamController = StreamController<bool>();
  Stream get stream => _streamController.stream;

  Future<User> getLoggedUser() async {
    User user = await User.get();
    return user;
  }

  Future<ApiResponse> authUser(String username, String password) async {
    _streamController.add(true);
    ApiResponse response = await Api.auth(username, password);
    _streamController.add(false);
    return response;
  }

  void dispose() {
    _streamController.close();
  }
}
