import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  var currencies = ['Francs', 'Dollars', 'Pounds', 'Yen'];
  var selectedname;

  String result = '';
  var form1 = GlobalKey<FormState>();

  TextEditingController principal = TextEditingController();
  TextEditingController rate = TextEditingController();
  TextEditingController terms = TextEditingController();

  @override
  void initState() {
    selectedname = currencies[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Simple Interest Calculator',
        theme: ThemeData(
          //brightness: Brightness.dark,
          primaryColor: Colors.deepOrangeAccent,
        ),
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('S.I CALCULATOR'),
          ),
          body: Form(
            key: form1,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: Image.asset(
                    'images/subrosa.jpg',
                    width: 256,
                    height: 256,
                  )),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      // ignore: missing_return
                      validator: (String input) {
                        if (input.isEmpty) {
                          return 'Please Enter the principal Amount';
                        }
                      },
                      controller: principal,
                      style: TextStyle(),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter principal eg : 12000',
                        labelText: 'enter principal Amount',
                        prefixIcon: Icon(Icons.attach_money),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      // ignore: missing_return
                      validator: (String input) {
                        if (input.isEmpty) {
                          return 'Please Enter the rate ';
                        }
                      },
                      controller: rate,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(fontSize: 15),
                        hintText: 'rate of interest in percentage ',
                        labelText: 'enter rate of interest  ',
                        prefixIcon: Icon(Icons.payment),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            keyboardType:TextInputType.number,
                            // ignore: missing_return,
                            validator: (String input) {
                              if (input.isEmpty) {
                                // ignore: missing_return
                                return "please enter terms ";
                              }
                            },
                            controller: terms,
                            decoration: InputDecoration(
                              hintText: 'Years',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: DropdownButton(
                            items: currencies.map((String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (itemselected) {
                              setState(() {
                                selectedname = itemselected;
                              });
                            },
                            value: selectedname,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            color: Colors.deepOrangeAccent,
                            child: Text(
                              'calculate',
                              style: TextStyle(color: Colors.white),
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                if (form1.currentState.validate()) {
                                  result = calculateInterest();
                                }
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RaisedButton(
                            color: Colors.black12,
                            child: Text('Reset',
                                textScaleFactor: 1.5,
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              setState(() {
                                reset();
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      result,
                      style: textStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  String calculateInterest() {
    double princv = double.parse(principal.text);
    double ratev = double.parse(rate.text);
    double termv = double.parse(terms.text);
    var calculate = princv + (princv * ratev * termv) / 100;
    String ans = 'After $termv your money is worth $calculate' + " " + '$selectedname';
    return ans;
  }

  void reset() {
    principal.text = '';
    rate.text = '';
    terms.text = '';
    selectedname = currencies[0];
    result = '';
  }
}
