import 'dart:async';
import 'package:getting_started/services/api/api.dart';
import 'package:getting_started/utils/simple_bloc.dart';

class LoginBloc extends SimpleBloc<bool> {
  Future<ApiResponse> authUser(String username, String password) async {
    ApiResponse response;
    try {
      add(true);
      response = await Api.auth(username, password);
      add(false);
    } catch (error) {
      addError(error);
      add(false);
    }
    return response;
  }
}
