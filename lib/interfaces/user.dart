import 'package:firebase_database/firebase_database.dart';

class User {
  String key;
  String username;
  String gender;
  String institution;
  String department;
  var area;
  String address;
  String mobile;
  String password;
  String email;

  User(this.username, this.gender, this.address, this.area, this.department,
      this.institution, this.mobile, this.password, this.email);

  User.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        username = snapshot.value["username"],
        gender = snapshot.value["gender"],
        institution = snapshot.value["institution"],
        department = snapshot.value["department"],
        area = snapshot.value["area"],
        address = snapshot.value["address"],
        mobile = snapshot.value["mobile"],
        password = snapshot.value["password"],
        email = snapshot.value["email"];

  toJson() {
    return {
      "username": username,
      "password": password,
      "gender": gender,
      "institution": institution,
      "department": department,
      "area": area,
      "address": address,
      "mobile": mobile,
      "email": email
    };
  }
}
