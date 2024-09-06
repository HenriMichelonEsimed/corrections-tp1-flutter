class UserAccount {
  late String displayname;
  late String login;
  String? password;

  UserAccount({required this.displayname, required this.login, this.password} );

  UserAccount.fromMap(Map<String, dynamic> json) {
    displayname = json['displayname'];
    login = json['login'];
  }

  Map<String, dynamic> toMap() {
    return {
      'displayname': displayname,
      'login' : login,
      'password' : password,
    };
  }
}