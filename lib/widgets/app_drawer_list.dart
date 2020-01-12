import 'package:flutter/material.dart';
import 'package:getting_started/pages/login_page.dart';
import 'package:getting_started/utils/navigation.dart';

class DrawerList extends StatelessWidget {
  final url =
      "https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn3.iconfinder.com%2Fdata%2Ficons%2Fvector-icons-6%2F96%2F256-512.png&imgrefurl=https%3A%2F%2Fwww.iconfinder.com%2Ficons%2F745386%2Favatar_profile_profile_avatar_user_user_avatar_user_profile_icon&docid=HcnaCc9Adht_mM&tbnid=5jDq_Kd-rUMH8M%3A&vet=10ahUKEwjy68msiv_mAhVvEbkGHRDhDXoQMwhgKAkwCQ..i&w=512&h=512&bih=635&biw=1366&q=user%20avatar&ved=0ahUKEwjy68msiv_mAhVvEbkGHRDhDXoQMwhgKAkwCQ&iact=mrc&uact=8";

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
