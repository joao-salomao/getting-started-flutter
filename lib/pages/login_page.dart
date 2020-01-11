import 'package:flutter/material.dart';
import 'package:getting_started/entities/user.dart';
import 'package:getting_started/pages/home_page.dart';
import 'package:getting_started/utils/api.dart';
import 'package:getting_started/utils/navigation.dart';
import 'package:getting_started/widgets/app_raised_button.dart';
import 'package:getting_started/widgets/app_text_form_field.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
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
            Container(
              width: double.infinity,
              child: AppRaisedButton(
                "Login",
                onPressed: _onClickLogin,
              ),
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

    print("Email: $email | Senha: $password");
    
    ApiResponse response = await Api.auth(email, password);
    
    if (response.ok) {
      User user = response.result;
      print(user);
      push(context, HomePage());
    } else {
      
    }
  }
}
