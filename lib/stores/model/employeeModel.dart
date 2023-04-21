class EmployeeModel {
  final int? id;
  final String userName;
  final String passWord;
  final String name;
  final String numberPhone;
  final String idNumber;
  final int age;
  final int sex;
  //0: nam, 1: nữ

  const EmployeeModel({
    this.id,
    required this.userName,
    required this.passWord,
    required this.name,
    required this.numberPhone,
    required this.age,
    required this.sex,
    required this.idNumber,
  });

  @override
  String toString() {
    return 'current list Product info: $id & $userName & $passWord & $name & $numberPhone & $sex & $age & $idNumber ';
  }

  Map toJson() => {
        'id': id,
        'userName': userName,
        'passWord': passWord,
        'name': name,
        'numberPhone': numberPhone,
        'idNumber': idNumber
      };

  static EmployeeModel fromJson(dynamic json) {
    if (json == null) {
      return const EmployeeModel(
        id: 0,
        userName: '',
        passWord: '',
        name: '',
        numberPhone: '',
        idNumber: '',
        age: 0,
        sex: 0,
      );
    }
    return EmployeeModel(
      id: json['id'] != null ? json['id'] as int : 0,
      userName: json['userName'] != null ? json['userName'] as String : '',
      passWord: json['passWord'] != null ? json['passWord'] as String : '',
      name: json['name'] != null ? json['name'] as String : '',
      numberPhone:
          json['numberPhone'] != null ? json['numberPhone'] as String : '',
      idNumber: json['idNumber'] != null ? json['idNumber'] as String : '',
      age: json['age'] != null ? json['age'] as int : 0,
      sex: json['sex'] != null ? json['sex'] as int : 0,
    );
  }
}

List<EmployeeModel> listEmployeeModel = [
  const EmployeeModel(
      id: 01,
      userName: 'cuongdoan01',
      passWord: '123456',
      name: 'Đoàn Quốc Cường',
      numberPhone: '0333849246',
      age: 18,
      sex: 0,
      idNumber: '034201003803'),
  const EmployeeModel(
      id: 02,
      userName: 'cuongdoan02',
      passWord: '123456',
      name: 'Đoàn Quốc Cường 02',
      numberPhone: '0333849246',
      age: 18,
      sex: 0,
      idNumber: '034201003803'),
  const EmployeeModel(
      id: 03,
      userName: 'cuongdoan03',
      passWord: '123456',
      name: 'Đoàn Quốc Cường 03',
      numberPhone: '0333849246',
      age: 18,
      sex: 0,
      idNumber: '034201003803'),
  const EmployeeModel(
      id: 04,
      userName: 'cuongdoan04',
      passWord: '123456',
      name: 'Đoàn Quốc Cường 04',
      numberPhone: '0333849246',
      age: 18,
      sex: 0,
      idNumber: '034201003803'),
  const EmployeeModel(
      id: 05,
      userName: 'cuongdoan05',
      passWord: '123456',
      name: 'Đoàn Quốc Cường 05',
      numberPhone: '0333849246',
      age: 18,
      sex: 0,
      idNumber: '034201003803'),
  const EmployeeModel(
      id: 06,
      userName: 'cuongdoan06',
      passWord: '123456',
      name: 'Đoàn Quốc Cường 06',
      numberPhone: '0333849246',
      age: 18,
      sex: 0,
      idNumber: '034201003803')
];
