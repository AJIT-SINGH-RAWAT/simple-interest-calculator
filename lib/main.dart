import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simple Interest Calculator App',
    home: siform(),
    theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent),
  ));
}

class siform extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return siformstate();
  }
}

class siformstate extends State<siform> {
var _formkey = GlobalKey<FormState>();


  var _currencies = ["Rupee", "Dollar", "Pound"];
  final minpadding = 5.0;
  var _currentitemselected = '';

  @override
  void initState() {
    super.initState();
    _currentitemselected = _currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();
  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: EdgeInsets.all(minpadding*2),
            child: ListView(
          children: <Widget>[
            getimageasset(),
            Padding(
                padding: EdgeInsets.only(top: minpadding, bottom: minpadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: principalController,
                  validator: (String value){
                    if (value.isEmpty){
                      return 'Please Enter Principal amount';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Principal',
                      hintText: 'Enter Principal e.g 12000',
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),
            Padding(
                padding: EdgeInsets.only(top: minpadding, bottom: minpadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: roiController,
                    validator: (String value){
                    if (value.isEmpty){
                      return 'Please Enter Rate Of Interest';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Rate Of Interest',
                      hintText: 'Rate in percent',
                      labelStyle: textStyle,
                       errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),
            Padding(
                padding: EdgeInsets.only(top: minpadding, bottom: minpadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextFormField(
                      style: textStyle,
                      controller: termController,
                        validator: (String value){
                    if (value.isEmpty){
                      return 'Please Enter Time';
                    }
                  },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Term ',
                          hintText: 'Time in years',
                          labelStyle: textStyle,
                           errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0
                      ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                    Container(
                      width: minpadding * 5,
                    ),
                    Expanded(
                        child: DropdownButton<String>(
                      items: _currencies.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: _currentitemselected,
                      onChanged: (String newValueSelected) {
                        _onDropDownItemSelected(newValueSelected);
                      },
                    ))
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(top: minpadding, bottom: minpadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        child: Text(
                          'Calculate',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                         
                          setState(() {
                             if (_formkey.currentState.validate()){
                            this.displayResult = _calculateTotalReturns();
                             }
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Reset',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            _reset();
                          });
                        },
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(top: minpadding, bottom: minpadding),
              child: Text(
                this.displayResult,
                style: textStyle,
              ),
            )
          ],
        )),
      ),
    );
  }

  Widget getimageasset() {
    AssetImage assetImage = AssetImage('images/money.jpg');
    Image image = Image(
      image: assetImage,
      width: 100.0,
      height: 100.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(minpadding * 10),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentitemselected = newValueSelected;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);
    double totalAmountPayable = principal + (principal * roi * term) / 100;
    String result =
        'After $term years , your investment will be worth $totalAmountPayable $_currentitemselected';
    return result;
  }

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    _currentitemselected = _currencies[0];
  }
}
