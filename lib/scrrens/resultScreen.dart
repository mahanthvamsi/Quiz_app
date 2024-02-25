import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultScreen extends StatelessWidget {
  final int points;
  final VoidCallback restartApp;
  const ResultScreen({required this.points, required this.restartApp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/Result.png",
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
            top: 370,
            left: 116,
            child: Column(
              children: [
                Text(
                  "Your Score is ",
                  style: GoogleFonts.poppins(
                      fontSize: 25,
                      color: Colors.yellow,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "$points ",
                  style: GoogleFonts.poppins(
                      fontSize: 25,
                      color: Colors.yellow,
                      fontWeight: FontWeight.w500),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shadowColor: Colors.purple,
                      backgroundColor: Colors.purple[300],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      fixedSize: Size(140, 50)),
                  onPressed: () {
                    restartApp();
                  },
                  child: Text("Restart",
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
