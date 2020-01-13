import 'package:flutter/material.dart';
import 'package:getting_started/entities/user.dart';
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
            FutureBuilder<User>(
              future: User.get(),
              builder: (context, snapshot) {
                User user = snapshot.data;
                return user != null ? _header(user) : Container();
              },
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

  UserAccountsDrawerHeader _header(User user) {
    return UserAccountsDrawerHeader(
            accountName: Text(user.nome),
            accountEmail: Text(user.email),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(user.urlFoto),
            ),
          );
  }

  _onClickLogout(BuildContext context) {
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}
