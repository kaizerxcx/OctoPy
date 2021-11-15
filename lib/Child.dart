import 'User.dart';

class Child extends User {
  int crazeOnPhonicPoints;
  int wordKitPoints;
  int alphaHopperPoints;
  int mazeCrazePoints;
  int readingSpreePoints;
  int total;
  double position;

  Child();
  Child.named(
      String firstname,
      String lastname,
      String username,
      this.crazeOnPhonicPoints,
      this.wordKitPoints,
      this.alphaHopperPoints,
      this.mazeCrazePoints,
      this.readingSpreePoints,
      this.total,
      this.position)
      : super.named(firstname, lastname, username);
}

class UserInsights {
  String label;
  double data;
  UserInsights(this.label, this.data);
}
