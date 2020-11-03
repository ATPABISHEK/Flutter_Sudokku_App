import 'package:flutter/foundation.dart';

class SudokkuSolver {
  var sudokkuTable = List.generate(
      9,
      (_) => List.generate(9, (_) => 0,
          growable: false), //It generates 9*9 sudokku table
      growable: false);
  var referTable = List.generate(
      9,
      (_) => List.generate(9, (_) => 0,
          growable: false), //It generates 9*9 sudokku table
      growable: false);
  var tempAns = List.generate(
      9, (_) => List.generate(9, (_) => 1, growable: false),
      growable: false);

  SudokkuSolver({
    @required this.sudokkuTable,
    @required this.referTable,
  });

  List<List<int>> get table {
    return sudokkuTable;
  }

  bool validateTable(int row, int col, int val) {
    //check row
    for (int i = 0; i < 9; i++) {
      if ((i != col) && sudokkuTable[row][i] == val)
        return false; //here only i am avoid checking same row col
    }
    //check col
    for (int i = 0; i < 9; i++) {
      if ((i != row) && sudokkuTable[i][col] == val) {
        return false;
      }
    }
    //check box
    int rowVal = ((row ~/ 3).toInt()) * 3;
    int colVal = ((col ~/ 3).toInt()) * 3;
    for (int i = rowVal; i < rowVal + 3; i++) {
      for (int j = colVal; j < colVal + 3; j++) {
        //if same row and column as check val then leave that
        if ((!(i == row && j == col)) && sudokkuTable[i][j] == val) {
          return false;
        }
      }
    }
    return true;
  }

  //check the row values
  bool checkRow(int row, int val) {
    for (int i = 0; i < 9; i++) {
      //in these code i am not avoid checking for value in the same col or row or box because when i am backtracking it will check for current value it will return false the code will increment tempAns which is needed
      if (sudokkuTable[row][i] == val) return false;
    }
    return true;
  }

  //check the column values
  bool checkCol(int col, int val) {
    for (int i = 0; i < 9; i++) {
      if (sudokkuTable[i][col] == val) {
        return false;
      }
    }
    return true;
  }

  //check the box values
  bool checkBox(int row, int col, int val) {
    int rowVal = ((row ~/ 3).toInt()) * 3;
    int colVal = ((col ~/ 3).toInt()) *
        3; //i debugged here to first convert to int then multiply 3
    //print(rowVal.toString()+colVal.toString());
    for (int i = rowVal; i < rowVal + 3; i++) {
      for (int j = colVal; j < colVal + 3; j++) {
        if (sudokkuTable[i][j] ==
            val) //debugged here to make i,j in correct place
        {
          //if(row==0&&col==7)print(i.toString()+j.toString());
          return false;
        }
      }
    }
    return true;
  }

  //solve the sudokku
  void solveSudokku() {
    int i = 0, j = 0, forward = 1;
    for (i = 0; i < 9; i++) {
      //print(i);
      //print(sudokkuTable);
      for (j = 0; j < 9;) {
        if (referTable[i][j] == 0) {
          //print('$i $j ${tempAns[i][j]}');
          //print(sudokkuTable);
          if (checkRow(i, tempAns[i][j]) &&
              checkCol(j, tempAns[i][j]) &&
              checkBox(i, j, tempAns[i][j])) {
            sudokkuTable[i][j] = tempAns[i][j];
            j++;
            forward = 1;
          } else {
            if (tempAns[i][j] == 9) {
              sudokkuTable[i][j] = 0;
              tempAns[i][j] = 1;
              j--;
              forward = 0;
              if (j == -1) {
                j = 8;
                i--;
                if (i < 0)
                  i = 0; //i added this because when hot reloading i goes -1
              }
            } else {
              tempAns[i][j]++;
            }
          }
        } //if value is given in the question
        else {
          if (forward == 1) {
            j++;
          } else {
            j--;
            if (j == -1) {
              i--;
              if (i < 0)
                i = 0; //i added this because when hot reloading i goes -1
              j = 8;
            }
          }
        } //if value is not given in question

      } //inner for loop
    } //outer for loop
  } //solveSudokku function

}

// void solveSudokku(int ipos, int jpos, int forward) {
//     //print('dfjsfj');
//     //print('$ipos $jpos ${tempAns[ipos][jpos]}');//if I run this line here program stops here why
//     //print('why');
//     if (ipos < 9) {
//       //when table value is not given in question
//       //print('$ipos $jpos ${tempAns[ipos][jpos]}');
//       //print(sudokkuTable);
//       if (referTable[ipos][jpos] == 0) {
//         //print('hi');
//         //print(checkRow(jpos,tempAns[ipos][jpos]));
//         if (checkRow(ipos, tempAns[ipos][jpos]) &&
//             checkCol(jpos, tempAns[ipos][jpos]) &&
//             checkBox(ipos, jpos, tempAns[ipos][jpos])) {
//           sudokkuTable[ipos][jpos] = tempAns[ipos][jpos];
//           jpos++;

//           if (jpos == 9) {//going to next row
//             ipos++;
//             jpos = 0;
//           }
//           print(ipos.toString()+' hi '+jpos.toString());
//           solveSudokku(ipos, jpos, 1);//here passing 1 to mention we are tracking forward
//         } else {
//           //print('aa');
//           if (tempAns[ipos][jpos] == 9) {
//             tempAns[ipos][jpos] = 1;
//             sudokkuTable[ipos][jpos]=0;//i debugged here to assign 0 when we go back
//             jpos--;
//             if (jpos == -1) {
//               ipos--;
//               jpos = 8;
//             }
//             solveSudokku(ipos, jpos, 0);//here passing 0 to mention we are tracking back
//           } else {
//             tempAns[ipos][jpos] += 1;
//             //print('hi');
//             solveSudokku(ipos, jpos, forward);
//           }
//         }
//       }
//       //when table value is given in question
//       else {
//         //print('aa');
//         if (forward == 1) {

//           jpos++;
//           if (jpos == 9) {
//             ipos++;
//             jpos = 0;
//           }
//         } else {
//           jpos--;
//           if (jpos == -1) {
//             jpos = 8;
//             ipos--;
//           }
//         }
//         solveSudokku(ipos, jpos, forward);
//       }
//     }
//     //print('i am here');
//     return;
//   }

// var sudokkuTable=[[5,3,0,0,7,0,0,0,0],
//                     [6,0,0,1,9,5,0,0,0],
//                     [0,9,8,0,0,0,0,6,0],
//                     [8,0,0,0,6,0,0,0,3],
//                     [4,0,0,8,0,3,0,0,1],
//                     [7,0,0,0,2,0,0,0,6],
//                     [0,6,0,0,0,0,2,8,0],
//                     [0,0,0,4,1,9,0,0,5],
//                     [0,0,0,0,8,0,0,7,9]];

//  var sudokkuTable=[[0,2,0,5,0,1,0,9,0],
//                     [8,0,0,2,0,3,0,0,6],
//                     [0,3,0,0,6,0,0,7,0],
//                     [0,0,1,0,0,0,6,0,0],
//                     [5,4,0,0,0,0,0,1,9],
//                     [0,0,2,0,0,0,7,0,0],
//                     [0,9,0,0,3,0,0,8,0],
//                     [2,0,0,8,0,4,0,0,7],
//                     [0,1,0,9,0,7,0,6,0]];

// var sudokkuTable=[[8,0,0,0,0,0,0,0,0],
//                     [0,0,3,6,0,0,0,0,0],
//                     [0,7,0,0,9,0,2,0,0],
//                     [0,5,0,0,0,7,0,0,0],
//                     [0,0,0,0,4,5,7,0,0],
//                     [0,0,0,1,0,0,0,3,0],
//                     [0,0,1,0,0,0,0,6,8],
//                     [0,0,8,5,0,0,0,1,0],
//                     [0,9,0,0,0,0,4,0,0]];
