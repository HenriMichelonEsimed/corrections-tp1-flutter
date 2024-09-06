import 'package:exo4/components.dart';
import 'package:exo4/consts.dart';
import 'package:exo4/model/useraccount.dart';
import 'package:exo4/pages/login.dart';
import 'package:exo4/services/useracccount_routes.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  SigninPage({super.key});
  final userRoutes = UserAccountRoutes();
  @override
  State<StatefulWidget> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _formKey = GlobalKey<FormState>();
  late String _displayName;
  late String _login;
  late String _password;
  String? _loginError;
  var processSignin = false;

  _signin() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState?.save();

    _loginError = null;
    try {
      await widget.userRoutes.get(_login);
      setState(() {
        _loginError = 'Login already in use';
      });
      return;
    } catch(e) {}

    if (context.mounted) {
      try {
        setState(() {
          processSignin = true;
        });
        await widget.userRoutes.insert(UserAccount(
            displayname: _displayName, login: _login, password: _password));
        if (context.mounted) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginPage()));
        }
      } catch (error) {
        showNetworkErrorDialog(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(child:Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Sign In'),
      ),
      body:Padding(padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child:Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            TextFormField(
              onSaved: (value) =>_displayName = value.toString(),
              validator: (value) => stringNotEmptyValidator(value, 'Please enter a name'),
              style: defaulTextStyle,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Display name',)),
            TextFormField(
              onSaved: (value) => _login = value.toString(),
              validator: (value) => stringNotEmptyValidator(value, 'Please enter a login name'),
              style: defaulTextStyle,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Login',
                errorText: _loginError
              )),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: (value) => _password = value.toString(),
              validator: (value) => stringNotEmptyValidator(value, 'Please enter a password'),
              style: defaulTextStyle,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password')),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please repeat the password';
                }
                if (value != _password) {
                  return 'The passwords does not matches';
                }
                return null;
              },
              style: defaulTextStyle,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Repeat password',)),
            if (processSignin)
              const Center(child: MyPadding(child: CircularProgressIndicator()))
            else
              SizedBox(
                width: double.infinity,
                child:MyPadding(
                  child: ElevatedButton(
                      onPressed: _signin,
                      child: const MyText('Sign in')))),

    ])))));
  }
}