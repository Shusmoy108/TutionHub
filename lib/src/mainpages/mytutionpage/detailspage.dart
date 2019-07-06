import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import '../../models/user.dart';
import '../alltutionpage/alltutionspage.dart';
import '../mytutionpage/mytutionpage.dart';
import '../notificationpage/notifications.dart';
import '../profilepage/profile.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DetailsPage extends StatefulWidget {
  User u;
   List<String> review;
  DetailsPage(this.u,this.review);
  @override
  State<StatefulWidget> createState() {
    return Details(u,review);
  }
}

class Details extends State<DetailsPage> {
  User u;
 List<String> review;
  Details(this.u,this.review);

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                title: new Text('Are you sure?'),
                content: new Text('Do you want to exit Tuition Hub'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text('No'),
                  ),
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: new Text('Yes'),
                  ),
                ],
              ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            appBar: AppBar(title: Text('Tuition Hub')),
            body: Container(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SmoothStarRating(
                        allowHalfRating: false,
                        starCount: 5,
                        rating: double.parse(u.rating),
                        size: 40.0,
                        color: Colors.green,
                        borderColor: Colors.green,
                      ),
                      stylishText('Name : ${u.username}', 15.0),
                      stylishText('Email : ${u.email}', 15.0),
                      stylishText('Gender : ${u.gender}', 15.0),
                      stylishText('Institution : ${u.institution}', 15.0),
                      stylishText('Department : ${u.department}', 15.0),
                      stylishText('Mobile Number : ${u.mobile}', 15.0),
                      stylishText('Area : ${u.area}', 15.0),
                      stylishText('Detailed Address : ${u.address}', 15.0),
                      stylishText("Reviews", 30.0),
                      getTextWidgets()
                     
                    ],
                  ),
                )));
  }
 
  Widget getTextWidgets()
  {
    List<Widget> list = new List<Widget>();
    print(review.length);
     print("madari");
    if(review.length==0){
        list.add(stylishText("No Reviews for the tutor at the moment", 15.0));
    }
    else{
    for(var i = 0; i < review.length; i++){
        list.add(stylishText(review[i], 15.0));
    }
    }
    return new Column(children: list);
    
  }
  Widget stylishText(text, size) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        //fontWeight: FontWeight.bold,
        color: Colors.black87,
        fontFamily: 'Merienda',
      ),
    );
  }

  Widget userField() {
    return ListTile(title: Text("hello"));
  }

  Widget nameField() {
    return ListTile(
        title: Text(
      'Name : ${u.username}',
      style: new TextStyle(fontSize: 15, color: Colors.black),
    ));
  }

  Widget emailField() {
    return ListTile(
        title: Text(
      'Email : ${u.email}',
      style: new TextStyle(fontSize: 15, color: Colors.black),
    ));
  }

  Widget insititutionField() {
    return ListTile(
        title: Text(
      'Institution : ${u.institution}',
      style: new TextStyle(fontSize: 15, color: Colors.black),
    ));
  }

  Widget departmentField() {
    return ListTile(
        title: Text(
      'Department : ${u.department}',
      style: new TextStyle(fontSize: 15, color: Colors.black),
    ));
  }

  Widget genderField() {
    return ListTile(
        title: Text(
      'Gender : ${u.gender}',
      style: new TextStyle(fontSize: 15, color: Colors.black),
    ));
  }

  Widget mobileField() {
    return ListTile(
        title: Text(
      'Mobile Number : ${u.mobile}',
      style: new TextStyle(fontSize: 15, color: Colors.black),
    ));
  }

  Widget areaField() {
    return ListTile(
        title: Text(
      'Area : ${u.area}',
      style: new TextStyle(fontSize: 15, color: Colors.black),
    ));
  }

  Widget addressField() {
    return ListTile(
        title: Text(
      'Detailed Address : ${u.address}',
      style: new TextStyle(fontSize: 15, color: Colors.black),
    ));
  }
}
