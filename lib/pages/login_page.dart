import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          _inputText(
            "Email",
            "Digite o seu email",
            controller: _emailController,
          ),
          _inputText(
            "Senha",
            "Digite a sua senha",
            obscureText: true,
            controller: _passwordController,
          ),
          _button(
            label: "Login",
            onPressed: _onClickLogin,
          ),
        ],
      ),
    );
  }

  void _onClickLogin() {
    String email = _emailController.text;
    String password = _passwordController.text;

    print("Email: $email | Senha: $password");
  }

  Widget _inputText(
    String label,
    String hint, {
    bool obscureText = false,
    TextEditingController controller,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(
        fontSize: 20,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
      ),
    );
  }

  Widget _button({@required String label, @required Function onPressed}) {
    return RaisedButton(
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      color: Colors.blue,
      onPressed: onPressed,
    );
  }
}
