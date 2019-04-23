import 'package:flutter/material.dart';
import 'tution.dart';

class Tutions extends StatelessWidget {
  final List<Tution> tutions;
  Tutions(this.tutions);

  Widget _buildProductItem(BuildContext context, int index) {
    print(tutions[index]);
    print("tut");
    return Card(
      child: Column(
        children: <Widget>[
          Text('Number Of Students : ${tutions[index].numberofstudent}',
              style: TextStyle(color: Colors.black)),
          Text(tutions[index].cls, style: TextStyle(color: Colors.black)),
          Text('Institution : ${tutions[index].institution}',
              style: TextStyle(color: Colors.black)),
          Text('Subject : ${tutions[index].subject}',
              style: TextStyle(color: Colors.black)),
          Text('Salary : ${tutions[index].salary}',
              style: TextStyle(color: Colors.black)),
          Text('Area : ${tutions[index].area}',
              style: TextStyle(color: Colors.black)),
          Text('Detailed Address : ${tutions[index].address}',
              style: TextStyle(color: Colors.black)),
          RaisedButton(
            color: Colors.blue,
            splashColor: Colors.blueGrey,
            textColor: Colors.white,
            onPressed: () => {debugPrint("hello")},
            child: Text("Interested", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(tutions);
    print("tut");
    return ListView.builder(
      itemBuilder: _buildProductItem,
      itemCount: tutions.length,
    );
  }
}
