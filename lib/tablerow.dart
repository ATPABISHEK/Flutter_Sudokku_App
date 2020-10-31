import 'package:flutter/material.dart';

class MyTableRow extends StatelessWidget {
  final List<int> tableRow;
  MyTableRow({@required this.tableRow});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: tableRow
          .map((value) => Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
              ),
              child: Text(
                value.toString(),
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              )))
          .toList(),
    );
  }
}
