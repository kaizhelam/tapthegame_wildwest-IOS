import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class MobileViewScreen extends StatefulWidget {
  const MobileViewScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MobileViewScreenState();
  }
}

class _MobileViewScreenState extends State<MobileViewScreen> {
  int score = 0;
  int timeLeft = 60;
  bool isGameStarted = false;
  Offset targetPosition = const Offset(100, 369);
  late Timer gameTimer;
  String currentTargetImage = 'assets/images/target1.png';

  void startGame() {
    setState(() {
      score = 0;
      timeLeft = 60;
      isGameStarted = true;
    });

    double timerInterval = 1.0;

    gameTimer =
        Timer.periodic(Duration(seconds: timerInterval.toInt()), (timer) {
          setState(() {
            if (timeLeft > 0) {
              timeLeft--;
            } else {
              timer.cancel();
              isGameStarted = false;
              _showGameOverDialog();
            }
          });
        });
  }

  void _moveTarget() {
    final random = Random();
    final screenSize = MediaQuery.of(context).size;
    final x = random.nextDouble() * (screenSize.width - 180);
    final y = max(170.0, random.nextDouble() * (screenSize.height - 180));

    setState(() {
      targetPosition = Offset(x, y);
    });
  }

  void _changeTargetImage() {
    final random = Random();
    setState(() {
      currentTargetImage = random.nextBool()
          ? 'assets/images/target1.png'
          : 'assets/images/target2.png';
    });
  }

  void _incrementScore() {
    setState(() {
      score++;
      _moveTarget();
      _changeTargetImage();
    });
  }

  void _showDialog(String title, String message, String buttonText,
      Function onButtonPressed) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Colors.transparent.withOpacity(0.7),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 28),
              ),
              const SizedBox(height: 20),
              Text(
                message,
                style: const TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onButtonPressed();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFFEFCA84),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                  ),
                  child: Text(
                    buttonText,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showGameOverDialog() {
    _showDialog(
      "Game Over",
      "Your final score is: $score",
      "Play Again",
      startGame,
    );
  }

  @override
  void initState() {
    super.initState();
    startGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 27,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textWidget("Score : $score", 23, Colors.black),
                textWidget("Time : $timeLeft", 23, Colors.black),
              ],
            ),
          ),
          if (isGameStarted)
            Positioned(
              left: targetPosition.dx,
              top: targetPosition.dy,
              child: GestureDetector(
                onTap: _incrementScore,
                child: Image.asset(
                  currentTargetImage,
                  width: 180,
                  height: 180,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget textWidget(String text, double size, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: color,
        fontSize: size,
      ),
    );
  }
}
