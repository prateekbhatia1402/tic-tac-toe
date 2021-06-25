import 'dart:math';
class Game {
  final List<String> board = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  final List<String> symbols ;
  Game(this.symbols);
  final List<int> winningCombo = [-1, -1,-1];
  int winStatus = -1;
  bool gameOn = true;
  String winMessage = '';
  int whosTurn(List<String> board) {
    int count = _movesMade(board);
    if (count % 2 == 0)
      return 0;
    else
      return 1;
  }

  int _movesMade(List<String> board) {
    int count = 0;
    board.forEach((element) {
      if (element != '') count++;
    });
    return count;
  }

  void reset() {
    board.fillRange(0, 9, '');
    winStatus = -1;
    gameOn = true;
    winMessage = '';
  }

  setValue(int index) {
    if (gameOn && board[index] == '') board[index] = symbols[whosTurn(board)];
  }

  int checkForWin() {
    if (board[0] != '' && board[0] == board[1] && board[0] == board[2]) {
      winStatus = symbols.indexOf(board[0]);
      winningCombo[0]=0;
      winningCombo[1]=1;
      winningCombo[2]=2;
    } else if (board[3] != '' && board[3] == board[4] && board[3] == board[5]) {
      winStatus = symbols.indexOf(board[3]);
      winningCombo[0]=3;
      winningCombo[1]=4;
      winningCombo[2]=5;
    } else if (board[6] != '' && board[6] == board[7] && board[6] == board[8]) {
      winStatus = symbols.indexOf(board[6]);
      winningCombo[0]=6;
      winningCombo[1]=7;
      winningCombo[2]=8;
    } else if (board[0] != '' && board[0] == board[3] && board[0] == board[6]) {
      winStatus = symbols.indexOf(board[0]);
      winningCombo[0]=0;
      winningCombo[1]=3;
      winningCombo[2]=6;
    } else if (board[1] != '' && board[1] == board[4] && board[1] == board[7]) {
      winStatus = symbols.indexOf(board[1]);
      winningCombo[0]=1;
      winningCombo[1]=4;
      winningCombo[2]=7;
    } else if (board[2] != '' && board[2] == board[5] && board[2] == board[8]) {
      winStatus = symbols.indexOf(board[2]);
      winningCombo[0]=8;
      winningCombo[1]=5;
      winningCombo[2]=2;
    } else if (board[0] != '' && board[0] == board[4] && board[0] == board[8]) {
      winStatus = symbols.indexOf(board[0]);
      winningCombo[0]=0;
      winningCombo[1]=4;
      winningCombo[2]=8;
    } else if (board[2] != '' && board[2] == board[4] && board[2] == board[6]) {
      winStatus = symbols.indexOf(board[2]);
      winningCombo[0]=6;
      winningCombo[1]=4;
      winningCombo[2]=2;
    } else if (board.contains('') == false) winStatus = 2;
    print('win status is $winStatus');
    if (winStatus != -1) {
      gameOn = false;
      if (winStatus == 2)
        winMessage = 'It is a draw';
      else
        winMessage = '${symbols[winStatus]} won';
    }
    print('win Message is $winMessage');
    return winStatus;
  }

  int checkWin(board) {
    if (board[0] != '' && board[0] == board[1] && board[0] == board[2]) {
      return symbols.indexOf(board[0]);
    } else if (board[3] != '' && board[3] == board[4] && board[3] == board[5]) {
      return symbols.indexOf(board[3]);
    } else if (board[6] != '' && board[6] == board[7] && board[6] == board[8]) {
      return symbols.indexOf(board[6]);
    } else if (board[0] != '' && board[0] == board[3] && board[0] == board[6]) {
      return symbols.indexOf(board[0]);
    } else if (board[1] != '' && board[1] == board[4] && board[1] == board[7]) {
      return symbols.indexOf(board[1]);
    } else if (board[2] != '' && board[2] == board[5] && board[2] == board[8]) {
      return symbols.indexOf(board[2]);
    } else if (board[0] != '' && board[0] == board[4] && board[0] == board[8]) {
      return symbols.indexOf(board[0]);
    } else if (board[2] != '' && board[2] == board[4] && board[2] == board[6]) {
      return symbols.indexOf(board[2]);
    } else if (board.contains('') == false)
      return 2;
    else
      return -1;
  }

  void doBestMove(List<String> board) {
    print('Best move for $board');
    int bestPos = _minMax(board);
    print('Chosen move $bestPos');
    setValue(bestPos);
  }

  int _minMax(List<String> board) {
    int turn = whosTurn(board);
    print('Turn of $turn');
    Map<int, int> points = Map();
    List<int> availableMoves = [];
    for (int i = 0; i < 9; i++)
      if (board[i] == '') {
        points[i] = 0;
        availableMoves.add(i);
      }
    print('Available moves $availableMoves');
    for (int i in availableMoves) {
      List<String> subBoard = board.toList();
      subBoard[i] = symbols[turn];
      points[i] += _minMaxPoints(subBoard);
    }
    print('Points are $points');
    int maxPoints = points[availableMoves[0]],
        minPoints = points[availableMoves[0]];
    List<int> 
        maxVal = [],
        minVal = [];
    points.forEach((key, value) {
      if (value > maxPoints) {
        maxVal.clear();
        maxPoints = value;
        maxVal.add(key);
      }
      else if(value == maxPoints)
        maxVal.add(key);
      if (value < minPoints) {
        minVal.clear();
        minPoints = value;
        minVal.add(key);
      }
      else if(value == minPoints)
        minVal.add(key);
    });
    
    if (turn == 0)
      {
        print('best moves are $maxVal');
        int index=Random().nextInt(maxVal.length);
        return maxVal[index];
      }
    else
      {
        print('best moves are $minVal');
        int index=Random().nextInt(minVal.length);
        return minVal[index];
        }
  }

  int _minMaxPoints(List<String> board) {
    int turn = whosTurn(board);
    Map<int, int> points = Map();
    
      int val = checkWin(board);
      if (val == 2)
        return 0;
      else if (val == 0)
        return 1;
      else if(val == 1)
        return -1;
    List<int> availableMoves = [];
    for (int i = 0; i < 9; i++)
      if (board[i] == '') {
        points[i] = 0;
        availableMoves.add(i);
      }
    
    for (int i in availableMoves) {
      List<String> subBoard = board.toList();
      subBoard[i] = symbols[turn];
      points[i] += _minMaxPoints(subBoard);
    }
    int maxPoints = points[availableMoves[0]],
        minPoints = points[availableMoves[0]];
    points.forEach((key, value) {
      if (value > maxPoints) maxPoints = value;
      if (value < minPoints) minPoints = value;
    });
    if (turn == 0)
      return maxPoints;
    else
      return minPoints;
  }

  void setBoard(List<String> b) {
    for (int i = 0; i < 9; i++) this.board[i] = b[i];
  }
}
