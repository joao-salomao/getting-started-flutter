import 'package:flutter/material.dart';
import 'package:getting_started/entities/user.dart';
import 'package:getting_started/pages/cars/login_bloc.dart';
import 'package:getting_started/utils/api.dart';
import 'package:getting_started/utils/navigation.dart';
import 'package:getting_started/widgets/app_alert.dart';
import 'package:getting_started/widgets/app_raised_button.dart';
import 'package:getting_started/widgets/app_text_form_field.dart';
import 'cars/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginBloc _bloc = LoginBloc();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(text: "user");
  final TextEditingController _passwordController =
      TextEditingController(text: "123");
  final FocusNode _passwordFocus = FocusNode();

  @override
  void initState() {
    _userIsLogged();
    super.initState();
  }

  _userIsLogged() async {
    User user = await User.get();
    if (user != null) {
      push(context, HomePage(), replace: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Login"),
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Form(
      key: _formKey,
      child: Container(
        height: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppTextFormField(
              "Email",
              "Digite o seu email",
              controller: _emailController,
              validator: _emailValidator,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              nextFocus: _passwordFocus,
            ),
            SizedBox(
              height: 16,
            ),
            AppTextFormField(
              "Senha",
              "Digite a sua senha",
              obscureText: true,
              controller: _passwordController,
              validator: _passwordValidator,
              focusNode: _passwordFocus,
            ),
            StreamBuilder(
              stream: _bloc.stream,
              builder: (context, snapshot) {
                return Container(
                  margin: EdgeInsets.only(top: 16),
                  width: double.infinity,
                  height: 50,
                  child: AppRaisedButton(
                    "Login",
                    onPressed: _onClickLogin,
                    isLoading: snapshot.hasData,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _emailValidator(String value) {
    if (value.isEmpty) {
      return "Digite o seu email";
    }
    return null;
  }

  String _passwordValidator(String value) {
    if (value.isEmpty) {
      return "Digite a sua senha";
    }
    return null;
  }

  void _onClickLogin() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    String email = _emailController.text;
    String password = _passwordController.text;

    ApiResponse response = await _bloc.authUser(email, password);

    if (response.ok) {
      final User user = response.result;
      user.saveToPrefs();
      push(context, HomePage(), replace: true);
    } else {
      alert(context, "Ops, algo deu errado", response.message);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.closeStream();
  }
}
