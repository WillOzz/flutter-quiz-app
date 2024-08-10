import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/main_menu.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/results_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  final List<String> selectedAnswers = [];
  var activeState = 'start-screen';
  void switchScreen() {
    setState(() {
      activeState = 'questions-screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeState = 'results-screen';
      
      });
    }
  }
  void restartQuiz(){
    setState(() {
      activeState = 'questions-screen';
        selectedAnswers.clear();
    });
  }

  @override
  Widget build(context) {
    Widget currentScreen = MainMenu(switchScreen);
    if (activeState == 'questions-screen') {
      currentScreen = QuestionsScreen(onSelectAnswer: chooseAnswer);
    }
    if (activeState == 'results-screen') {
      currentScreen =  ResultsScreen(chosenAnswers: selectedAnswers,restartQuiz);
    }
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 81, 17, 134),
                Color.fromARGB(255, 102, 26, 163),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: currentScreen,
        ),
      ),
    );
  }
}
