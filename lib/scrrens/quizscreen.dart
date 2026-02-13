import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app_finesse/questionlist.dart';
import 'package:quiz_app_finesse/scrrens/introscreen.dart';
import 'package:quiz_app_finesse/scrrens/resultScreen.dart';
import 'package:quiz_app_finesse/widgets/customcontainer.dart';
import 'package:quiz_app_finesse/widgets/topwidget.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  //THE MAP WILL STORE OPTION WHICH USER WILL SELECT INDEXING STARTS FROM ZERO
  Map<int, int?> userAnswers = {};
  //NUMBER OF POINTS USER IS SELECTING
  int points = 0;
  PageController controller = PageController();
  bool _isQuizComplete() {
    return userAnswers.length == questions.length;
  }

  void _onOptionSelected(int questionIndex, int optionIndex) {
    setState(() {
      int correctIndex = questions[questionIndex].correctanswerindex;

      // If already answered before, remove old score
      if (userAnswers.containsKey(questionIndex)) {
        if (userAnswers[questionIndex] == correctIndex) {
          points--;
        }
      }

      // Save new answer
      userAnswers[questionIndex] = optionIndex;

      // Add score if new answer is correct
      if (optionIndex == correctIndex) {
        points++;
      }
    });
  }
  void _previousQuestion() {
    if (controller.page! > 0) {
      controller.previousPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextQuestion() {
    if (controller.page! < questions.length - 1) {
      controller.nextPage(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) => ResultScreen(
            points: points,
            restartApp: _restartQuiz,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Slide from right
            const begin = Offset(0.5, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            final offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        ),
      );
    }
  }

  void _restartQuiz() {
    setState(() {
      userAnswers.clear();
      points = 0;
    });
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Introscreen()),
        (route) => false);
  }
    Color _getOptionColor(int questionIndex, int optionIndex) {
      if (!userAnswers.containsKey(questionIndex)) {
        return Colors.white;
      }

      final selected = userAnswers[questionIndex];
      final correct = questions[questionIndex].correctanswerindex;

      if (optionIndex == correct) {
        return Colors.green.shade200; // correct answer
      }

      if (optionIndex == selected && selected != correct) {
        return Colors.red.shade200; // wrong selected
      }

      return Colors.white;
    }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: questions.length,
      itemBuilder: (context, index) {
        bool isLastQuestion = index == questions.length - 1;
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Stack(
                  children: [
                    TopWidget(),
                    Positioned(
                      top: 310,
                      left: 40,
                      right: 20,         // IMPORTANT: instead of fixed width layout
                      bottom: 0,         // gives space and prevents cutting
                      child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomContainer(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    spreadRadius: 1,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Question ${index + 1} of ${questions.length}",
                                  style: GoogleFonts.poppins(
                                      fontSize: 23,
                                      color: Colors.purple,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(questions[index].question_text as String,
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                            ),
                            width: 316,
                            height: (questions[index].question_text?.length ?? 0) > 40 ? 140 : 100,
                          ),
                          SizedBox(
                            height: 38,
                          ),
                          Column(
                            children:
                                List.generate(questions[index].answers!.length,
                                    (optionIndex) {
                              final isSelected =
                                  userAnswers[index] == optionIndex;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 18.0),
                                child: GestureDetector(
                                  onTap: () {
                                    if (!userAnswers.containsKey(index)) {
                                      _onOptionSelected(index, optionIndex);
                                    }
                                  },
                                  child: CustomContainer(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 2,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                      color: _getOptionColor(index, optionIndex),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: 50,
                                    width: 280,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            "${questions[index].answers![optionIndex]}",
                                            style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              color: userAnswers.containsKey(index)
                                                  ? Colors.black
                                                  : Colors.purple,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // BUTTON SECTION
                          isLastQuestion
                              ? Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Back Button
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey.shade300,
                                      fixedSize: Size(110, 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    onPressed: () {
                                      controller.previousPage(
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                                    child: Text(
                                      "Back",
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),

                                  SizedBox(width: 15),

                                  // End Quiz Button
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: _isQuizComplete()
                                          ? Colors.redAccent
                                          : Colors.grey,
                                      fixedSize: Size(140, 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    onPressed: _isQuizComplete()
                                        ? _nextQuestion
                                        : () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "Please answer all questions",
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "End Quiz",
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // Progress Text
                              if (!_isQuizComplete())
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    "${userAnswers.length}/${questions.length} answered",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Back button (hide on first question)
                                if (index > 0)
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey.shade300,
                                      fixedSize: Size(110, 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    onPressed: () {
                                      controller.previousPage(
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                                    child: Text(
                                      "Back",
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),

                                if (index > 0) SizedBox(width: 15),

                                // Next / Skip
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xffCFAFF0),
                                    fixedSize: Size(110, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: _nextQuestion,
                                  child: Text(
                                    userAnswers.containsKey(index) ? "Next" : "Skip",
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
