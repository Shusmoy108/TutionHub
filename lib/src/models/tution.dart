import 'package:firebase_database/firebase_database.dart';

class Tution {
  String key;
  String cls;
  var subject=[];
  String salary;
  String institution;
  String area;
  var interested = [];
  String status;
  String address;
  String tid;
  String uid;
  String uemail;
  String uname;
  String numberofstudent;
  String f = 'x';
  String unbooknumber = "0";
  String tutorname;
  String tutoremail;
  String tutorid;

  Tution(this.cls, this.subject, this.salary, this.address, this.area,
      this.institution, this.numberofstudent);

  Tution.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        cls = snapshot.value["cls"],
        subject = snapshot.value["subject"],
        salary = snapshot.value["salary"],
        institution = snapshot.value["institution"],
        area = snapshot.value["area"],
        address = snapshot.value["address"],
        uid = snapshot.value["uid"],
        numberofstudent = snapshot.value["numberofstudent"],
        status = snapshot.value["status"],
        interested = snapshot.value["interseted"];

  toJson() {
    return {
      "cls": cls,
      "subject": subject,
      "salary": salary,
      "institution": institution,
      "area": area,
      "uid": uid,
      "address": address,
      "numberofstudent": numberofstudent,
      "status": status,
      "interested": interested,
      'uemail': uemail,
      'uname': uname,
      "unbooknumber": unbooknumber
    };
  }
}
