class User {
  int id;
  String email;
  String username;
  String password;
  String name;

  User(
      {required this.id,
      required this.email,
      required this.username,
      required this.password,
      required this.name});

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
        id: data['id'],
        email: data['email'],
        username: data['username'],
        password: data['password'],
        name: data['name']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'password': password,
      'name': name
    };
  }
}
