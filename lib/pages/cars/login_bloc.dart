import 'dart:async';
import 'package:getting_started/entities/user.dart';
import 'package:getting_started/utils/api.dart';

class LoginBloc {
  final StreamController _streamController = StreamController<bool>();
  Stream get stream => _streamController.stream;

  Future<User> getLoggedUser() async {
    try {
      User user = await User.get();
      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<ApiResponse> authUser(String username, String password) async {
    try {
      _streamController.add(true);
      ApiResponse response = await Api.auth(username, password);
      _streamController.add(false);
      return response;
    } catch (error) {
      _streamController.addError(error);
    }
  }

  void dispose() {
    _streamController.close();
  }
}
