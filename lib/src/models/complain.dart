import 'package:firebase_database/firebase_database.dart';

class Complain {
  String key;
  String complain;
  String tutorname;
  String tutoremail;
  String tutorid;
  String uid;
  String tutionid;
  int time;
  Complain(this.complain, this.tutorname, this.tutoremail, this.tutorid,
      this.uid, this.tutionid);
  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }

  Complain.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        complain = snapshot.value["complain"],
        tutorname = snapshot.value["tutorname"],
        tutoremail = snapshot.value["tutoremail"],
        tutorid = snapshot.value["tutorid"],
        uid = snapshot.value["uid"],
        tutionid = snapshot.value["tutionid"];
  toJson() {
    return {
      "complain": complain,
      "tutorname": tutorname,
      "tutoremail": tutoremail,
      "tutorid": tutorid,
      "uid": uid,
      "tutionid": tutionid,
    };
  }
}