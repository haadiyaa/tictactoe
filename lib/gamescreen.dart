import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  final String player1;
  final String player2;
  const GameScreen({
    super.key,
    required this.player1,
    required this.player2,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<List<String>> _board;
  late String _currentPlayer;
  late String _winner;
  late bool _gameOver;

  @override
  void initState() {
    super.initState();
    _board = List.generate(3, (_) => List.generate(3, (_) => ""));
    _currentPlayer = "X";
    _winner = "";
    _gameOver = false;
  }

  void resetGame() {
    setState(() {
      _board = List.generate(3, (_) => List.generate(3, (_) => ""));
      _currentPlayer = "X";
      _winner = "";
      _gameOver = false;
    });
  }

  void makeMove(int row, int col) {
    if (_board[row][col] != "" || _gameOver) {
      return;
    }
    setState(() {
      _board[row][col] = _currentPlayer;
      if (_board[row][0] == _currentPlayer &&
          _board[row][1] == _currentPlayer &&
          _board[row][2] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      } else if (_board[0][col] == _currentPlayer &&
          _board[1][col] == _currentPlayer &&
          _board[2][col] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      } else if (_board[0][0] == _currentPlayer &&
          _board[1][1] == _currentPlayer &&
          _board[2][2] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      } else if (_board[0][2] == _currentPlayer &&
          _board[1][1] == _currentPlayer &&
          _board[2][0] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      }

      _currentPlayer = _currentPlayer == "X" ? "O" : "X";

      if (!_board.any((row) => row.any((cell) => cell == ""))) {
        _gameOver = true;
        _winner = 'It\'s a tie';
      }

      if (_winner != "") {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          btnOkText: 'Play Again',
          title: _winner=="X"?"${widget.player1} Won!":_winner=="O"?"${widget.player2} Won!":"it's a tie",
          btnOkOnPress: () {
            resetGame();
          },
        ).show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 10, 63, 22),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
