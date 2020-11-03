import 'package:flutter/material.dart';

//my packages
import './tablerow.dart';

class MyTable extends StatelessWidget {
  final List<List<int>> table;
  final Function resetTable;
  MyTable({@required this.table, @required this.resetTable});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: 40.0,
        ), //for some distancing
        ...table
            .map(
              (row) => MyTableRow(tableRow: row),
            )
            .toList(),
        SizedBox(
          height: 30.0,
        ), //for some distancing
        RaisedButton(
          color: Theme.of(context).primaryColor,
          onPressed: () {
            resetTable(); //reset previously Typed values
            Navigator.of(context).pop();
          },
          child: Text(
            'Reset',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ]),
    );
  }
}
