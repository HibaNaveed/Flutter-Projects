import 'dart:ui';
import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var input = "";
  var result = "";
  void button(String value) {
    setState(() {
      if (value == '=') {
        try {
          result = _evaluateExpression(input);
          input = '';
        } catch (e) {
          result = 'Error';
        }
      } else if (value == 'C') {
        input = '';
        result = '';
      } else {
        input += value;
      }
    });
  }

  String _evaluateExpression(String input) {
    final expression = Expression.parse(input);
    final evaluator = const ExpressionEvaluator();
    var result = evaluator.eval(expression, {});

    return result.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Calculator",
            style: TextStyle(
              color: Color(0xff8e757c),
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            height: 450,
            width: 300,
            decoration: BoxDecoration(
              color: Color(0xffdccfd3),
              border: Border.all(
                color: Color(0xff8e757c),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    input,
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.right,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    result,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildButton('7'),
                    buildButton('8'),
                    buildButton('9'),
                    buildButton('/'),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildButton('4'),
                    buildButton('5'),
                    buildButton('6'),
                    buildButton('*'),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildButton('1'),
                    buildButton('2'),
                    buildButton('3'),
                    buildButton('-'),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildButton('C'),
                    buildButton('0'),
                    buildButton('='),
                    buildButton('+'),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildButton(String value) {
    return ElevatedButton(
      onPressed: () => button(value),
      child: Text(value, style: TextStyle(fontSize: 24)),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(20),
        minimumSize: Size(70, 70),
      ),
    );
  }
}
