class User {
  int id = -1;
  String username;
  String password;
  String firstname;
  String lastname;
  String email;
  int age;

  User();
  User.named(this.firstname, this.lastname, this.username);
}
