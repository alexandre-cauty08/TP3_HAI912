import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/Question.dart';
import 'QuestionState.dart';

class QuestionCubit extends Cubit<QuestionState> {

  late final List<Question> questions;
  final List<Widget> score = [];

  bool fini = false;
  int compteur = 0;
  int questionNum = 0;
  int total = 0;
  late Question _question;

  QuestionCubit({required this.questions})
      : super(QuestionState(0,
      Question(questionText: questions[0].questionText,
          reponse: false,
      thematic: "",
      imagePath: questions[0].imagePath))) {
    _question = questions[questionNum];
  }


  List<Question> get _questions => questions;
  bool get setFini => fini;
  int get questionNumber => questionNum;
  int get gettotal => total;
  int get numberQuestions => questions.length;
  Question get question => _question;

  set setFini(bool number){
    fini = number;
    emit(QuestionState(questionNum,_question));
    }



  checkAnswer(bool userChoice, BuildContext context) {
    // Cas d'une réponse correcte choisie par l'utilisateur
    if (questions[questionNum].reponse == userChoice) {
      total = total + 1;
      score.add(const Icon(Icons.check, color: Colors.green));
      emit(QuestionState(questionNum, _question));

    }
    // Cas contraire
    else {
      score.add(const Icon(Icons.close, color: Colors.red));
      emit(QuestionState(questionNum, _question));

    }

  }


  nextQuestion() {
    if (questionNum< _questions.length - 1) {
      questionNum++;
      _question = _questions[questionNum];
      emit(QuestionState(questionNum, _question));

    } else {
      fini = true;
      emit(QuestionState(questionNum, _question));
    }

  }

  reset(){
    questionNum = 0;
    _question = _questions[questionNum];
    emit(QuestionState(questionNum, _question));
    total = 0;
    compteur = 0;
    fini = false;
    score.clear();
  }
}