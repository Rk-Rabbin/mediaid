class User {
  int? id;
  String? token;
  String? username;
  String? email;

  User({
    this.email,
    this.id,
    this.username,
  });

//{"pk":2,"username":"","email":"example1@gmail.com","first_name":"First","last_name":"Last"}
  factory User.fromJson(json) {
    print(json);
    return User(
      email: json["email"],
      id: json["pk"],
      username: json["username"],
    );
  }
}