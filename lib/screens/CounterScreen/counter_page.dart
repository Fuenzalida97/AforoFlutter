import 'package:flutter/material.dart';
import 'package:aforo_app/controllers/counter.dart';

class CounterPage extends StatelessWidget{

  int value = 0;

  void _increment() {
      value++;
  }
  void _decrement() {
      value--;
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text('Counter App'),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '$value',
                  style: TextStyle(fontSize:80.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: _increment,
                      child: Icon(Icons.add),
                      tooltip: 'Increment',
                    ),
                    SizedBox(width: 20.0),
                    FloatingActionButton(
                      onPressed: _decrement,
                      child: Icon(Icons.remove),
                      tooltip: 'Decrement',
                    ),

                  ],)
              ],
            )));
  }

}