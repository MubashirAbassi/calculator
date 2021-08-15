

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SIform(),
    theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent),
  ));
}

class SIform extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SIformstate();
  }
}

class SIformstate extends State<SIform> {
  final minpadding = 5.0;
  var names = ['Mubusher', 'qurashi', 'husnain', 'fazal', 'faheem'];
  var value = "mubusher";
  var citems = "Mubusher";
  var newvalues;
  var displayresult = "";
  var formkey= GlobalKey<FormState>();
  var emassage="please fill the field";
  TextEditingController pcontroller = TextEditingController();
  TextEditingController rcontroller = TextEditingController();

  TextEditingController tcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.headline6;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Appbar"),
        centerTitle: true,
      ),
      body: Form(
        key: formkey,
          child: Padding(
        padding: EdgeInsets.all(minpadding * 2 ),
        child: ListView(
          children: [
            Image(
              image: AssetImage("assets/cal.png"),
            ),
            Padding(
              padding: EdgeInsets.only(top: minpadding, bottom: minpadding),
              child: TextFormField (
                controller: pcontroller,
                validator:(value){
                  if(value !=null && value.isEmpty){
                    return emassage;
                  }
                },
                keyboardType: TextInputType.number,
                style: textStyle,
                decoration: InputDecoration(
                    labelText: "Principal",
                    hintText: "Enter Principal eg 12000",
                    labelStyle: textStyle,
                    errorStyle: TextStyle(color: Colors.yellowAccent,fontSize: 15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: minpadding, bottom: minpadding),
              child: TextFormField(
                controller: rcontroller,
                validator:(value){
                  if(value !=null && value.isEmpty){
                    return emassage;
                  }
                },
                keyboardType: TextInputType.number,
                style: textStyle,
                decoration: InputDecoration(
                    labelText: "Rate of Interest",
                    hintText: "In Persent(%)",
                    labelStyle: textStyle,
                    errorStyle: TextStyle(color: Colors.yellowAccent,fontSize: 15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: minpadding, bottom: minpadding),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: tcontroller,
                      validator:(value){
                        if(value !=null && value.isEmpty){
                          return emassage;
                        }
                      },
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      decoration: InputDecoration(
                          labelText: "Term",
                          hintText: "Time in Years",
                          labelStyle: textStyle,
                          errorStyle: TextStyle(color: Colors.yellowAccent,fontSize: 15.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    ),
                  ),
                  Container(
                    width: minpadding * 5,
                  ),
                  Expanded(
                      child: DropdownButton<String>(
                    items: names.map((String name) {
                      return DropdownMenuItem<String>(
                        value: name,
                        child: Text(name),
                      );
                    }).toList(),

                    onChanged: (newvalues) {
                      if(value!= null) {
                        setState(() {
                          dditems(this.newvalues = citems);
                        });
                      }},
                        value: citems,
                  )),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: minpadding, bottom: minpadding),
                child: Row(
                  children: [
                    Expanded(
                        child: RaisedButton(
                            color: Theme.of(context).primaryColorDark,
                            textColor: Theme.of(context).primaryColorLight,
                            child: Text(
                              "Calculate",
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                 if(formkey.currentState!.validate()){
                                  this.displayresult = ctotals();
                                }});
                            })),
                    Expanded(
                        child: RaisedButton(
                      color: Theme.of(context).primaryColorLight,
                      textColor: Theme.of(context).primaryColorDark,
                      child: Text(
                        "Reset",
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          reset();
                        });
                      },
                    ))
                  ],
                )),
            Padding(
                padding: EdgeInsets.all(minpadding * 2),
                child: Center(
                  child: Text(
                    this.displayresult,
                    style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold),
                  ),
                ))
          ],
        ),
      )),
    );
  }

  Widget getImage() {
    AssetImage assetImage = AssetImage('assets/cal.png');
    Image image = Image(image: assetImage, width: 200.0, height: 200.0);
    return Container(
      child: image,
      margin: EdgeInsets.all(minpadding * 10),
    );
  }

  void dditems(String newvalues) {
    setState(() {
      this.citems = newvalues;
    });
  }

  String ctotals() {
    double principal = double.parse(pcontroller.text);
    double rate = double.parse(rcontroller.text);

    double term = double.parse(tcontroller.text);
    double tamount = principal + (principal * rate * term) / 100;
    String result =
        "After $term Years, Your Total Investment will be worth $tamount Rupees";
    return result;
  }

  void reset() {
    pcontroller.text = "";
    rcontroller.text = "";
    tcontroller.text = "";
    displayresult = "";
    citems = names[2];

  }
}
