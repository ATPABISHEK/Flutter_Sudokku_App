import 'package:flutter/material.dart';

class InputTableRow extends StatefulWidget {
  final List<TextEditingController> listTextEditingController;
  InputTableRow({@required this.listTextEditingController});
  @override
  _InputTableRowState createState() => _InputTableRowState();
}

class _InputTableRowState extends State<InputTableRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.listTextEditingController.map((textEditingCont) {
        return Container(
          width: 40.0,
          height: 40.0,
          child: TextField(
            controller: textEditingCont,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0)),
            ),
          ),
        );
      }).toList(),
    );
  }
}
