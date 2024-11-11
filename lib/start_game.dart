import 'package:flutter/material.dart';
import 'mobile_screen.dart';

class StartGame extends StatelessWidget {
  const StartGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the height of the screen
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFEFCA84),
      body: Column(
        children: [
          // Background Image at the top of the screen, full width and dynamic height
          Center(
            child: Container(
              height: screenHeight * 0.7, // Adjust this to your preference, e.g., 70% of the screen height
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                  // Optional: Fit the image to the container
                ),
              ),
            ),
          ),
          // Adjust the positioning of the Start Game button
          Padding(
            padding: const EdgeInsets.only(top: 20.0), // Adjust this to control how high the button is
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MobileViewScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(4, 4),
                        blurRadius: 8,
                      ),
                    ],
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFEFCA84),
                        Color(0xFFFF7043),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: const Text(
                    "Start Game",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          color: Colors.black38,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
