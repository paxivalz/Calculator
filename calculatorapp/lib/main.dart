import 'dart:developer';
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    ));

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  //start data
  String result = "0";
  String out = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  //when press button state
  buttonPressed(String btnVal) {
    log(btnVal); //show button value

    //clear
    if (btnVal == "C") {
      out = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "0";
    }
    //cal operator before or press
    else if (btnVal == "+" || btnVal == "-" || btnVal == "*" || btnVal == "/") {
      num1 = double.parse(result); //num1 => change double to str
      operand = btnVal; //operator to cal [str]
      out = "0";
      result = result + btnVal;
    }
    //when press double value '.'
    else if (btnVal == ".") {
      if (out.contains(".")) {
        log("Already exist"); //don't press '.' more
        return;
      } else {
        out = out + btnVal; //str [xx+.]
      }
    }
    //cal when press '='
    else if (btnVal == "=") {
      num2 = double.parse(result); //num2 => change double to str
      if (operand == "+") {
        out = (num2 + num1).toString();
      }
      if (operand == "-") {
        out = (num1 - num2).toString();
      }
      if (operand == "*") {
        out = (num2 * num1).toString();
      }
      if (operand == "/") {
        out = (num1 / num2).toString();
      }
      num1 = 0.0;
      num2 = 0.0;
    } else {
      out = out + btnVal; //if press something after '='
    }

    setState(() {
      result =
          double.parse(out).toStringAsFixed(2); //result show fixed double [.xx]
      log(result);
    });
  }

  //button
  Widget buildButton(String ButtonVal) {
    return Expanded(
        child: Container(
      padding: const EdgeInsets.all(0.0),
      margin: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: MaterialButton(
        padding: const EdgeInsets.all(30.0),
        child: Text(
          ButtonVal,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        onPressed: () => buttonPressed(ButtonVal),
      ),
    ));
  }

  //UI calculator
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey[300],
          body: Column(
            children: <Widget>[
              //show number
              Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 50.0),
                  child: Text(
                    result, //show result
                    style: const TextStyle(fontSize: 60.0),
                  )),
              const Expanded(
                child: Divider(),
              ),
              //show button calculator
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      buildButton("C"),
                      buildButton("."),
                      buildButton("*"),
                      buildButton("/"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      buildButton("7"),
                      buildButton("8"),
                      buildButton("9"),
                      buildButton("+")
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      buildButton("4"),
                      buildButton("5"),
                      buildButton("6"),
                      buildButton("-")
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      buildButton("1"),
                      buildButton("2"),
                      buildButton("3"),
                      buildButton("0")
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      buildButton("="),
                    ],
                  )
                ],
              ),
            ],
          )),
    );
  }
}
