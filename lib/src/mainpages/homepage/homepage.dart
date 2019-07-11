
import 'package:TuitionHub/src/mainpages/mytutionpage/mytutionpage.dart';
import 'package:TuitionHub/src/mainpages/profilepage/profilepage.dart';
import 'package:flutter/material.dart';
import '../notificationpage/notifications.dart';
import '../../models/user.dart';
import '../alltutionpage/alltutionspage.dart';


class HomePage extends StatefulWidget {
  User u;
  HomePage(this.u);
  @override
  State<StatefulWidget> createState() {
    return _HomePageState(u);
  }
}

class _HomePageState extends State<HomePage>{
User u;
_HomePageState(this.u);
 
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
    return  WillPopScope(
        onWillPop: _onWillPop,
        child:Scaffold(
          backgroundColor: Color.fromRGBO(28,19,90, 1.0),
      body: Center(
            child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                     
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(children: <Widget>[
                        SizedBox(
                        width: 50.0,
                      ),
                        alltutionbutton(),
                          SizedBox(
                        width: 50.0,
                      ),
                         mytutionbutton(),
                      ],),
                     SizedBox(
                        height: 20.0,
                      ),
                      Row(children: <Widget>[
                        SizedBox(
                        width: 50.0,
                      ),
                        profilebutton(),
                          SizedBox(
                        width: 50.0,
                      ),
                         notibutton(),
                      ],),
                    ],
                  ),
          ),
             
            
          
        
      
    ),);
  }

   Widget profilebutton() {
    return InkWell(
      onTap: () {
        var router = new MaterialPageRoute(
                  builder: (BuildContext context) => new Profile(u));
              Navigator.of(context).push(router);
      },
      child: Container(
        width: 120,
        height: 100,
        decoration: BoxDecoration(
          color: Color.fromRGBO(204, 243, 129, 1.0),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            //BoxShadow(color: Colors.grey, offset: Offset(1, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Profile',
              style: TextStyle(
                  color: Colors.black, fontSize: 15.0, fontFamily: 'Merienda'),
            ),
            SizedBox(
              width: 0.0,
            ),
          ],
        ),
      ),
    );
  }
 Widget alltutionbutton() {
    return InkWell(
      onTap: () {
        var router = new MaterialPageRoute(
                  builder: (BuildContext context) => new AllTutionPage(u));
              Navigator.of(context).push(router);
      },
      child: Container(
        width: 120,
        height: 100,
        decoration: BoxDecoration(
           color: Color.fromRGBO(204, 243, 129,  1.0),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            //BoxShadow(color: Colors.grey, offset: Offset(1, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Tutor',
              style: TextStyle(
                  color: Colors.black, fontSize: 15.0, fontFamily: 'Merienda'),
            ),
            SizedBox(
              width: 0.0,
            ),
          ],
        ),
      ),
    );
  }
   Widget mytutionbutton() {
    return InkWell(
      onTap: () {
        var router = new MaterialPageRoute(
                  builder: (BuildContext context) => new MyTutionPage(u));
              Navigator.of(context).push(router);
      },
      child: Container(
        width: 120,
        height: 100,
        decoration: BoxDecoration(
          color: Color.fromRGBO(204, 243, 129,  1.0),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            //BoxShadow(color: Colors.grey, offset: Offset(1, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Guardian',
              style: TextStyle(
                  color: Colors.black, fontSize: 15.0, fontFamily: 'Merienda'),
            ),
            SizedBox(
              width: 0.0,
            ),
          ],
        ),
      ),
    );
  }
   Widget notibutton() {
    return InkWell(
      onTap: () {
        var router = new MaterialPageRoute(
                  builder: (BuildContext context) => new Notifications(u));
              Navigator.of(context).push(router);
      },
      child: Container(
        width: 120,
        height: 100,
        decoration: BoxDecoration(
           color: Color.fromRGBO(204, 243, 129, 1.0),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            //BoxShadow(color: Colors.grey, offset: Offset(1, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Notification',
              style: TextStyle(
                  color: Colors.black, fontSize: 15.0, fontFamily: 'Merienda'),
            ),
            SizedBox(
              width: 0.0,
            ),
          ],
        ),
      ),
    );
  }
  Widget loginbutton() {
    return InkWell(
      onTap: () {
       
      },
      child: Container(
        width: 120,
        height: 100,
        decoration: BoxDecoration(
           color: Color.fromRGBO(244,169,80, 1.0),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            //BoxShadow(color: Colors.grey, offset: Offset(1, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Login',
              style: TextStyle(
                  color: Colors.black, fontSize: 15.0, fontFamily: 'Merienda'),
            ),
            SizedBox(
              width: 0.0,
            ),
          ],
        ),
      ),
    );
  }

}
