import 'package:exo4/consts.dart';
import 'package:exo4/repositories/login_state.dart';
import 'package:exo4/main.dart';
import 'package:exo4/pages/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
              child: Text(appTitle)
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("List of cars"),
            onTap: () =>
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage())),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Log out"),
            onTap: () {
              Provider.of<LoginState>(context, listen: false).disconnect();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
            },
          )
      ]));
  }
}