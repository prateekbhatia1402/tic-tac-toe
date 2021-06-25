import 'package:flutter/material.dart';
import 'package:tick_tack_toe/runner.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _against;
  String _firstTurn='P';
  void _againstChanged(String val){
    setState((){_against=val;
      if(_against=='C')
      _firstTurn='P';
      else _firstTurn='X';
    });
  }
  @override
  void initState(){
    _against='C';_personSymbol='X';
  }
  String _personSymbol;
  void _firstTurnChanged(String val){
    setState((){_firstTurn=val;});
  }
  void _personSymbolChanged(String val){
    setState((){_personSymbol=val;});
  }
  Widget _gameSettings(){
    List<Widget> settings=<Widget>[];
    if(_against=='C'){
      settings.addAll([
        Text('First Turn  would be of')
      ,
          Row(
            children: <Widget>[
              Radio(value: 'C',groupValue: _firstTurn,onChanged: _firstTurnChanged,),
              Text('Computer')
            ],
          ), 
           Row(
            children: <Widget>[
              Radio(value: 'P',groupValue: _firstTurn,onChanged: _firstTurnChanged,),
              Text('Person')
            ],
          ),
          Text('You will play as ')
           ,
          Row(
            children: <Widget>[
              Radio(value: 'O',groupValue: _personSymbol,onChanged: _personSymbolChanged,),
              Text(' O '),
              Radio(value: 'X',groupValue: _personSymbol,onChanged: _personSymbolChanged,),
              Text(' X '),
            ],
          ), 
          ]);
    }
    else{
      settings.addAll([
        Text('First Turn  would be of')
      ,
          Row(
            children: <Widget>[
              Radio(value: 'O',groupValue: _firstTurn,onChanged: _firstTurnChanged,),
              Text(' O ')
            ],
          ), 
           Row(
            children: <Widget>[
              Radio(value: 'X',groupValue: _firstTurn,onChanged: _firstTurnChanged,),
              Text(' X ')
            ],
          ),
          ]);
    }
    return Column(children: settings);
  }
  void startGame(){
    bool compFirst;
    String turn;
    if(_against=='C'){
      if(_firstTurn=='P'){
        compFirst=false;
        if(_personSymbol=='X')turn='X';
        else turn='Y';}
      else{
        compFirst=true;
        if(_personSymbol=='X')turn='O';
        else turn='X';
      }
    }
    else turn=_firstTurn;
    Navigator.push(context,MaterialPageRoute(builder: (context)=>
     GameBoard(_against,turn=='X'?['X','O']:['O','X'],compFirst)
     ));
  }
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Tick Tac Toe')),
      body: Center(
        child: Column(children: <Widget>[
          Text('Play Against'),
          Row(
            children: <Widget>[
              Radio(value: 'C',groupValue: _against,onChanged: _againstChanged,),
              Text('Computer')
            ],
          ),
          Row(
            children: <Widget>[
              Radio(value: 'P',groupValue: _against,onChanged: _againstChanged,),
              Text('Person')
            ],
          ),
          _gameSettings(),
        ]),
      ),
      bottomSheet: FlatButton(child:Text('Start'),onPressed: startGame,),
    );
  } 
}
