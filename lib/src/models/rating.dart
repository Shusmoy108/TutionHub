import 'package:firebase_database/firebase_database.dart';

class Rating {
  String key;
  String rating;
  String id;
  int time;
  Rating(this.rating, this.id);
  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }

  Rating.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        rating = snapshot.value["rating"],
        id = snapshot.value["id"];
  toJson() {
    return {
      "rating": rating,
      "id": id,
    };
  }
}
