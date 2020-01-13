import 'package:flutter/material.dart';
import 'package:getting_started/pages/login_page.dart';
import 'package:getting_started/utils/navigation.dart';

class DrawerList extends StatelessWidget {
  final url ="http://www.livroandroid.com.br/livro/carros/classicos/Dodge_Challenger.png";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("João Salomão"),
              accountEmail: Text("xxxx@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(url),
              ),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              subtitle: Text("Sair do Aplicativo"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => _onClickLogout(context),
            ),
          ],
        ),
      ),
    );
  }

  _onClickLogout(BuildContext context) {
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}
