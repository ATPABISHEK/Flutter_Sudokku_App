import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            //maxLength: 1, //to restrict to enter only one number
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1)
            ], //max length property requires to set countertext:'' but it will not need it
            decoration: InputDecoration(
              //counterText:
              //'', //it will hid the lable below every textField like 1/0
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0)),
            ),
          ),
        );
      }).toList(),
    );
  }
}
