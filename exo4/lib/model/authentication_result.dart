class AuthenticationResult {
  late String displayname;
  late String login;
  late String token;

  AuthenticationResult(this.displayname, this.login, this.token);

  AuthenticationResult.fromMap(Map<String, dynamic> json) {
    displayname = json['displayname'];
    login = json['login'];
    token = json['token'];
  }

}