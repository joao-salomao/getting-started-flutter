class User {
  String nome;
  String login;
  String email;
  String token;
  List<String> roles;

  User.fromJson(Map<String, dynamic> map):
    login = map['login'],
    nome = map['nome'],
    email = map['email'],
    token = map['token'];

  @override
  String toString() {
    return "Usuário = Nome: $nome Login: $login Email: $email Token: $token";
  }
}