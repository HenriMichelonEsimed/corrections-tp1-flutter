import 'dart:convert';

import 'package:exo4/model/authentication_result.dart';
import 'package:exo4/model/useraccount.dart';
import 'package:exo4/services/carapi.dart';
import 'package:http/http.dart' as http;

class UserAccountRoutes extends CarAPI {
  static const userAccountRoutes = '${CarAPI.apiUrl}/useraccount';

  Future insert(UserAccount useraccount) async {
    var result = await http.post(Uri.http(CarAPI.apiServer, userAccountRoutes), body: useraccount.toMap());
    if (result.statusCode != 200) throw StatusErrorException(result.statusCode);
  }

  Future get(String login) async {
    var result = await http.get(Uri.http(CarAPI.apiServer, '$userAccountRoutes/$login'));
    if (result.statusCode != 200) throw StatusErrorException(result.statusCode);
  }

  Future<AuthenticationResult> authenticate(String login, String password) async {
    var result = await http.post(Uri.http(CarAPI.apiServer, '$userAccountRoutes/authenticate'),
        body: { 'login' : login, 'password' : password});
    if (result.statusCode != 200) throw StatusErrorException(result.statusCode);
    final Map<String, dynamic> datas = jsonDecode(result.body);
    return AuthenticationResult.fromMap(datas);
  }

}