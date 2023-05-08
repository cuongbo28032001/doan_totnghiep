class EmployeeModel {
  int? id;
  String? name;
  String? username;
  String? email;
  String? password;
  String? phone;
  int? sex;
  int? birthDay;
  String? deleted;
  List<Roles>? roles;
  String? cccd;

  EmployeeModel(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.password,
      this.phone,
      this.sex,
      this.birthDay,
      this.deleted,
      this.roles,
      this.cccd});

  @override
  String toString() {
    // TODO: implement toString
    return 'user: $id & $name & $username & $password $email & $phone & $birthDay & $cccd & $sex';
  }

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      sex: json['sex'],
      birthDay: json['birthDay'],
      deleted: json['deleted'],
      roles: json['roles'] != null
          ? List<Roles>.from(json['roles']
              .map((x) => Roles.fromJson(x))) // Chuyển đổi list kho từ JSON
          : null,
      cccd: json['cccd'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    data['sex'] = sex;
    data['birthDay'] = birthDay;
    data['deleted'] = deleted;
    data['roles'] = roles!.map((e) => e.toJson()).toList();
    data['cccd'] = cccd;
    return data;
  }
}

class Roles {
  int? id;
  String? name;

  Roles({this.id, this.name});

  factory Roles.fromJson(Map<String, dynamic> json) {
    return Roles(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
