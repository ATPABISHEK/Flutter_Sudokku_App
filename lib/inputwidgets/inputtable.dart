import 'package:flutter/material.dart';

//my packages
import 'inputtablerow.dart';

class InputTable extends StatefulWidget {
  final List<List<TextEditingController>> textEditingController;
  InputTable({@required this.textEditingController});
  @override
  _InputTableState createState() => _InputTableState();
}

class _InputTableState extends State<InputTable> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.textEditingController
            .map((listTextEditingCont) =>
                InputTableRow(listTextEditingController: listTextEditingCont))
            .toList(),
      ),
    );
  }
}
