import 'package:flutter/material.dart';
import 'game.dart';
import 'package:auto_size_text/auto_size_text.dart';
  bool _againstComputer;
  bool _computerFirst;
  List<String> _symbols;
class GameBoard extends StatelessWidget {
  GameBoard(String against,List<String> symbols,bool compFirst){
    _againstComputer=(against=="C")?true:false;
    _computerFirst=compFirst;
    _symbols=symbols;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Game')),
        body: GameBody(),
        bottomNavigationBar: Row(children: <Widget>[FlatButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('EXIT')),
        FlatButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> 
            GameBoard(_againstComputer?'C':'P',_symbols,_computerFirst)));
        }, child: Text('Reset'))],),
      ),
    );
  }
}
class GameBody extends StatefulWidget {
  @override
  _GameBodyState createState() => _GameBodyState();
}

class _GameBodyState extends State<GameBody> {
  Game game;
  String _message="";
  void boardClicked(int index){
    setState((){
      game.setValue(index);
      //List<String> dummy=['','','',
       //                   '','','',
        //                  '','',''];
     // game.setBoard(dummy);
      game.checkForWin();
      _message=game.winMessage;
      if(_againstComputer && game.gameOn ){
      int whosTurn=game.whosTurn(game.board);
     //r print('whose turn $whosTurn');
      if((_computerFirst && whosTurn==0) || (!_computerFirst &&whosTurn==1))
      {game.doBestMove(game.board);
        game.checkForWin();
      _message=game.winMessage;
        }
      else _message='Invalid Move';
      }
    });
  }
  
  @override 
  void initState(){
    game=new Game(_symbols);
    if(_againstComputer && _computerFirst)
      game.doBestMove(game.board);
  }
  void reset(){
    setState((){game.reset();});
  }

  List<Widget> getLayout(){
    double height=MediaQuery.of(context).size.height,width=MediaQuery.of(context).size.width;
    double minPercent=0.70,maxPercent=0.80;
    if(width<height)
     { 
       height=width;
     }
     else{
       height=height-60;
       width=height;
     }
    BoxConstraints boardConstraints=BoxConstraints(maxHeight: height*maxPercent,maxWidth: width*maxPercent,minHeight: height*minPercent,minWidth: width*minPercent);
    
    BoxConstraints cellConstraints= BoxConstraints(maxHeight: (height/3)*maxPercent,maxWidth: (width/3)*maxPercent,minHeight: (height/3)*minPercent,minWidth: (width/3)*minPercent);
    TextStyle regularStyle=TextStyle(fontSize:64,color:Colors.black);
    TextStyle winningStyle=TextStyle(fontSize:64,color:Colors.red);
    return <Widget>[
          Container(
            constraints: boardConstraints,
            child: Column(
              children: <Widget>[
               Row(children: <Widget>[
                 InkWell(
                 child: Container(constraints: cellConstraints,
                       child: 
                       AutoSizeText(game.board[0], 
                       style: (game.winningCombo.contains(0))?winningStyle:regularStyle),
                       decoration: BoxDecoration(border: Border(right: BorderSide(width:4),
                   bottom:BorderSide(width: 4))),
                   ),
                   onTap: () => boardClicked(0),
                 ),
                 InkWell(
                 child: Container(constraints: cellConstraints,
                       child: AutoSizeText(game.board[1],
                       style: (game.winningCombo.contains(1))?winningStyle:regularStyle),
                       decoration: BoxDecoration(border: Border(right: BorderSide(width:4),
                 bottom:BorderSide(width: 4))),
                 ),
                   onTap: () => boardClicked(1),
                 ),
                 InkWell(
                 child: Container(constraints: cellConstraints,
                       child: AutoSizeText(game.board[2],style: (game.winningCombo.contains(2))?winningStyle:regularStyle),
                       decoration: BoxDecoration(border: Border(bottom:BorderSide(width: 4))),
                 ),
                   onTap: () => boardClicked(2),
                 ),
               ],),
               Row(children: <Widget>[
                 InkWell(
                 child: Container(constraints: cellConstraints,
                       child: AutoSizeText(game.board[3],style: (game.winningCombo.contains(3))?winningStyle:regularStyle),
                       decoration: BoxDecoration(border: Border(right: BorderSide(width:4),
                 bottom:BorderSide(width: 4))),
                 ),
                   onTap: () => boardClicked(3),
                 ),
                 InkWell(
                 child: Container(constraints: cellConstraints,
                       child: AutoSizeText(game.board[4],style: (game.winningCombo.contains(4))?winningStyle:regularStyle),
                       decoration: BoxDecoration(border: Border(right: BorderSide(width:4),
                 bottom:BorderSide(width: 4))),
                 ),
                   onTap: () => boardClicked(4),
                 ),
                 InkWell(
                 child:Container(constraints: cellConstraints,
                       child: AutoSizeText(game.board[5],style: (game.winningCombo.contains(5))?winningStyle:regularStyle),
                       decoration: BoxDecoration(border: Border(bottom:BorderSide(width: 4))),
                 ),
                   onTap: () => boardClicked(5),
                 ),
               ],),
               Row(children: <Widget>[
                 InkWell(
                 child:Container(constraints: cellConstraints,
                       child: AutoSizeText(game.board[6],style: (game.winningCombo.contains(6))?winningStyle:regularStyle),
                       decoration: BoxDecoration(border: Border(right: BorderSide(width:4))),
                 ),
                   onTap: () => boardClicked(6),
                 ),
                 InkWell(
                 child:Container(constraints: cellConstraints,
                       child: AutoSizeText(game.board[7],style: (game.winningCombo.contains(7))?winningStyle:regularStyle),
                       decoration: BoxDecoration(border: Border(right: BorderSide(width:4))),
                 ),
                   onTap: () => boardClicked(7),
                 ),
                 InkWell(
                 child:Container(constraints: cellConstraints,
                       child: AutoSizeText(game.board[8],style: (game.winningCombo.contains(8))?winningStyle:regularStyle),),
                   onTap: () => boardClicked(8),
                 ),
               ],),
             ],),
          ),
             Container(decoration:
              BoxDecoration(border: _message==''?null:Border.all()),
              padding: EdgeInsets.all(8),
              child: Text(_message,style: TextStyle(fontSize: 24,),)
              )
    ];
        
  }
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height,width=MediaQuery.of(context).size.width;
    double minPercent=0.70,maxPercent=0.80;
    print('before height width $height $width');
    if(width<height)
     { 
       height=width;
      return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:getLayout() 
    
    );
     }
    else 
      {
        width=height;
        return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:getLayout() 
    
    );
      }
    print('after height width $height $width');
    
  }
}