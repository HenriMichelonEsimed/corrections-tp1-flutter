import 'package:exo4/components.dart';
import 'package:exo4/consts.dart';
import 'package:exo4/repositories/login_state.dart';
import 'package:exo4/main.dart';
import 'package:exo4/model/authentication_result.dart';
import 'package:exo4/model/useraccount.dart';
import 'package:exo4/pages/signin.dart';
import 'package:exo4/services/carapi.dart';
import 'package:exo4/services/useracccount_routes.dart';
import 'package:exo4/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  final userRoutes = UserAccountRoutes();

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late String _login;
  late String _password;
  var processLogin = false;
  late Future<AuthenticationResult> _authResult;

  _dologin() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState?.save();
    _authResult = widget.userRoutes.authenticate(_login, _password).then((authResult) {
      Provider.of<LoginState>(context, listen: false).token = authResult.token;
      Provider.of<LoginState>(context, listen: false).user =
          UserAccount(displayname: authResult.displayname, login: authResult.login);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => const MyHomePage()));
      return authResult;
    });
    setState(() {
      processLogin = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child:Padding(padding: const EdgeInsets.fromLTRB(20, 200, 20, 20),
        child:Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              const SizedBox(
                width: double.infinity,
                height: 100,
                child: Text(appTitle,textAlign: TextAlign.center, style: TextStyle(fontSize: 40))),
              TextFormField(
                onSaved: (value) => _login = value.toString(),
                validator: (v) => stringNotEmptyValidator(v, 'Please enter a login name'),
                style: defaulTextStyle,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Login')),
              TextFormField(
                onSaved: (value) => _password = value.toString(),
                validator: (v) => stringNotEmptyValidator(v, 'Please enter a password'),
                style: defaulTextStyle,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password')),
              if (processLogin)
                FutureBuilder(
                  future: _authResult,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      processLogin = false;
                      final errorMessage = snapshot.error is StatusErrorException ?
                          "Invalid username or password" : "Network error, please try again later";
                      return Column(children: [
                          MyPadding(child: MyText(errorMessage)),
                          LoginButton(onPressed: _dologin)
                        ]);
                    }
                    return const Center(child: MyPadding(child: CircularProgressIndicator()));
                  })
              else
                LoginButton(onPressed: _dologin),
              SizedBox(
                width: double.infinity,
                child:MyPadding(
                    child: ElevatedButton(
                        onPressed: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) => SigninPage())),
                        child: const MyText('Sign in'))))
    ]))));
  }
}