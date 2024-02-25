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
  void _onOptionSelected(int questionIndex, int optionIndex) {
    print(userAnswers);
    setState(() {
      //CHECK IF AN ANSWER IS ALREADY BEEN SELECTED FOR THE PARTICULAR QUESTIONS
      if (userAnswers.containsKey(questionIndex)) {
        userAnswers.remove(questionIndex);
      } else {
        if (questions[questionIndex].correctanswerindex == optionIndex) {
          points++;
        }
      }
      userAnswers[questionIndex] = optionIndex;
      print(points);
    });
  }

  void _nextQuestion() {
    if (controller.page! < questions.length - 1) {
      controller.nextPage(
          duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            points: points,
            restartApp: _restartQuiz,
          ),
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

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      itemCount: questions.length,
      itemBuilder: (context, index) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Stack(
                  children: [
                    TopWidget(),
                    Positioned(
                      top: 330,
                      left: 40,
                      child: Column(
                        children: [
                          CustomContainer(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    spreadRadius: 3,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Question ${index + 1}",
                                  style: GoogleFonts.poppins(
                                      fontSize: 23,
                                      color: Colors.purple,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(questions[index].question_text as String,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                            width: 316,
                            height: 100,
                          ),
                          SizedBox(
                            height: 30,
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
                                    _onOptionSelected(index, optionIndex);
                                  },
                                  child: CustomContainer(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 2,
                                          spreadRadius: 3,
                                        ),
                                      ],
                                      color: isSelected
                                          ? Color(0xffCFAFF0)
                                          : Colors.white,
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
                                              color: isSelected
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
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shadowColor: Colors.black,
                                backgroundColor: Color(0xffCFAFF0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                fixedSize: Size(110, 50)),
                            onPressed: () {
                              _nextQuestion();
                            },
                            child: Text("Next",
                                style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
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
