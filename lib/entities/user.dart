class User {
  String nome;
  String login;
  String email;
  String token;
  List<String> roles;

  User.fromJson(Map<String, dynamic> map)
      : login = map['login'],
        nome = map['nome'],
        email = map['email'],
        token = map['token'],
        roles = map['roles'] != null
            ? map['roles'].map<String>((role) => role.toString()).toList()
            : null;

  @override
  String toString() {
    return "Nome: $nome Login: $login Email: $email Token: $token Roles: $roles";
  }
}
