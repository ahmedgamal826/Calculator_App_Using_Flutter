import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Simple_Calculator(),
    );
  }
}


class Simple_Calculator extends StatefulWidget {
  const Simple_Calculator({Key? key}) : super(key: key);

  @override
  State<Simple_Calculator> createState() => _Simple_CalculatorState();
}

class _Simple_CalculatorState extends State<Simple_Calculator> {

  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;



  buttonPressed(String buttonText)
  {
    setState(()
    {
      if(buttonText == "C")
      {
        equation = "0";
        result = "0";

      }

      else if(buttonText == "⌫")
      {
        equation = equation.substring(0, equation.length - 1);
        if(equation == "")
        {
          equation = "0";
        }

      }

      else if(buttonText == "=")
      {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');


        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);


          ContextModel cm = ContextModel();

          result = '${exp.evaluate(EvaluationType.REAL, cm)}';



        }catch(e)
        {
          result = "Error";
        }


      }

      else
      {
        if(equation == "0")
        {
          equation = buttonText;
        }
        else {
          equation = equation + buttonText;
        }
      }

    });

  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor, Color backgroundButton) {


    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: RawMaterialButton(






            onPressed: ()  => buttonPressed(buttonText),

            //shape: CircleBorder(),
            fillColor: backgroundButton,


            child: Text(

              buttonText,
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(child: Text("Simple Calculator",
          style: TextStyle(
            fontSize: 23,
          ),),),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 30),
            child: Text(
              equation,
              style: TextStyle(
                fontSize: equationFontSize,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              color: Colors.black,
            ),
          ),

          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(
                fontSize: resultFontSize,
              ),
            ),
          ),
          Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [TableRow(children: [

                    buildButton("C", 1 , Colors.grey, Colors.red),
                    buildButton("⌫", 1 , Colors.grey, Colors.blue),
                    buildButton("%", 1 , Colors.grey, Colors.blue),




                  ]),

                    TableRow(children: [

                      buildButton("7", 1 , Colors.grey, Colors.blue),
                      buildButton("8", 1 , Colors.grey, Colors.blue),
                      buildButton("9", 1 , Colors.grey, Colors.blue),




                    ]),


                    TableRow(children: [

                      buildButton("4", 1 , Colors.grey, Colors.blue),
                      buildButton("5", 1 , Colors.grey, Colors.blue),
                      buildButton("6", 1 , Colors.grey, Colors.blue),




                    ]),

                    TableRow(children: [

                      buildButton("1", 1 , Colors.grey, Colors.blue),
                      buildButton("2", 1 , Colors.grey, Colors.blue),
                      buildButton("3", 1 , Colors.grey, Colors.blue),




                    ]),

                    TableRow(children: [

                      buildButton("0", 1 , Colors.grey, Colors.blue),
                      buildButton(".", 1 , Colors.grey, Colors.blue),
                      buildButton("=", 1 , Colors.grey, Colors.blue),




                    ]),





                  ],


                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("÷", 1, Colors.grey, Colors.blue),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("×", 1, Colors.grey, Colors.blue),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("-", 1, Colors.grey, Colors.blue),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("+", 2, Colors.grey, Colors.red),
                        ]
                    ),



                  ],
                ),








              ),
            ],
          )
        ],
      ),
    );
  }
}
