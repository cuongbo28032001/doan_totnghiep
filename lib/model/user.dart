class User {
  static final User _instance = User._internal();
  String? userName;

  factory User() {
    return _instance;
  }

  User._internal();

  String? get user => userName;

  set user(String? value) {
    userName = value;
  }
}
