import 'dart:async';
import 'package:getting_started/utils/api.dart';
import 'package:getting_started/utils/simple_bloc.dart';

class LoginBloc extends SimpleBloc<bool> {
  Future<ApiResponse> authUser(String username, String password) async {
    try {
      add(true);
      ApiResponse response = await Api.auth(username, password);
      add(false);
      return response;
    } catch (error) {
      addError(error);
    }
  }
}
