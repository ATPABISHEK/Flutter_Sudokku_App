import 'package:flutter/material.dart';

//my packages
import './table.dart';
import './inputwidgets/inputtable.dart';
import './sudokkusolver.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MySudokku(),
  ));
}

class MySudokku extends StatefulWidget {
  @override
  _MySudokkuState createState() => _MySudokkuState();
}

class _MySudokkuState extends State<MySudokku> {
  var _sudokkuTable = List.generate(
      9, (_) => List.generate(9, (_) => 0, growable: false),
      growable: false);

  var _referTable = List.generate(
      9, (_) => List.generate(9, (_) => 0, growable: false),
      growable: false);

  List<List<TextEditingController>> _textEditingController = List.generate(9,
      (_) => List.generate(9, (_) => TextEditingController(), growable: false),
      growable: false);

  List<List<int>> _tempTable = List.generate(
      9, (_) => List.generate(9, (_) => 0, growable: false),
      growable: false);

  void _solvedSudokkuTable() {
    var ss =
        SudokkuSolver(sudokkuTable: _sudokkuTable, referTable: _referTable);
    ss.solveSudokku();
    setState(() {
      _tempTable = ss.table;
    });
  }

  void _resetTable() {
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        _textEditingController[i][j].clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sudokku Solver'),
      ),
      body: Center(
        child: Container(
          child: InputTable(
            textEditingController: _textEditingController,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String text;
          int val;
          for (int i = 0; i < 9; i++) {
            for (int j = 0; j < 9; j++) {
              text = _textEditingController[i][j].text;
              if (text.isEmpty) {
                val = 0;
              } else {
                val = int.parse(text);
              }
              _sudokkuTable[i][j] = val;
              _referTable[i][j] = val;
            }
          }
          _solvedSudokkuTable();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Scaffold(
                    appBar: AppBar(
                      title: Text('Sudokku Solver'),
                    ),
                    body: MyTable(
                      table: _tempTable,
                      resetTable:
                          _resetTable, //thisfunction is to reset table whne reset button pressed
                    ),
                  )));
        },
        child: Text('Solve'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
