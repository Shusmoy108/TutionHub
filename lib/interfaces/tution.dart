import 'package:firebase_database/firebase_database.dart';

class Tution {
  String key;
  String cls;
  String subject;
  String salary;
  String institution;
  String area;
  String address;
  String numberofstudent;

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
        numberofstudent = snapshot.value["numberofstudent"];

  toJson() {
    return {
      "cls": cls,
      "subject": subject,
      "salary": salary,
      "institution": institution,
      "area": area,
      "address": address,
      "numberofstudent": numberofstudent,
    };
  }
}
