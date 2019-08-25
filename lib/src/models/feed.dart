import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Feeds {
  String key;
  String feedback;
  String uid;
  String uname;
  String uemail;
  String rating;
  
  String r="x";
  int time;
  Feeds(this.feedback,
      this.uid,this.uname,this.time,this.uemail);
  @override


  Feeds.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        feedback = snapshot.value["feedback"],
        uid = snapshot.value["uid"],
        uname = snapshot.value["uname"],
        rating = snapshot.value["rating"],
        time = snapshot.value["time"],
        uemail = snapshot.value["uemail"];

  toJson() {
    return {
      "feedback": feedback,
      "uid": uid,
 
      "time": time,
      "uname":uname,
      "uemail":uemail,
    
      "rating":rating
    };
  }
}
