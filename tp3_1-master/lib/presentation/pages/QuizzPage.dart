import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


import '../../buisness_logic/cubits/QuestionCubit.dart';
import '../../buisness_logic/cubits/QuestionState.dart';
import '../../data/dataproviders/Imagesprovider.dart';
import '../../data/dataproviders/Questionprovider.dart';
import '../../data/models/Question.dart';

class QuizPage extends StatelessWidget {
  QuizPage({Key? key, required this.thematic}) : super(key: key);

  final String thematic;
  final QuestionProvider _provider = QuestionProvider();
  final ImagesProvider _imagesProvider = ImagesProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _provider.getQuestionsByThematic(thematic),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Une erreur est survenue...');
          } else if (snapshot.hasData) {
            return Provider<QuestionCubit>(
              create: (_) =>
                  QuestionCubit(questions: snapshot.data!),
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[

                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: BlocBuilder<QuestionCubit, QuestionState>(
                                builder: (context, state) {
                              return FutureBuilder<String>(
                                future: _imagesProvider
                                    .getImage(state.question.imagePath),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData)
                                  {
                                    if(state.question.thematic == "Maths"){
                                      return Image.asset("images/maths.jpg");
                                    }
                                    if(state.question.thematic == "Français"){
                                      return Image.asset("images/français.png",);
                                    }
                                    if(state.question.thematic == "SVT"){
                                      return Image.asset("images/français.png",);
                                    }
                                    return Image.network(snapshot.data!);

                                  } else
                                  {
                                    return Image.asset('images/français.png');
                                  }
                                },
                              );
                            }),
                          ),
                      Container(
                        width: 300,
                        height: 150,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white24),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        child: Center(
                          child: BlocBuilder<QuestionCubit, QuestionState>(
                              builder: (context, state) => Text(
                              state.question.questionText,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                                textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            BlocBuilder<QuestionCubit, QuestionState>(
                                builder: (context, container) {
                                return Padding(
                                  padding: EdgeInsets.all(20),
                                  child: ButtonTheme(
                                    minWidth: 60.0,
                                    height: 35.0,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        context.read<QuestionCubit>().compteur++;
                                        if (context.read<QuestionCubit>().compteur == 1) {
                                          context.read<QuestionCubit>().checkAnswer(
                                              true, context);
                                        }
                                      },
                                      child: const Text('VRAI'),
                                    ),
                                  ),
                                );
                              return const SizedBox(width: 0, height: 0);
                            }),
                            BlocBuilder<QuestionCubit, QuestionState>(
                                builder: (context, container) {
                                return Padding(
                                  padding: EdgeInsets.all(20),
                                  child: ButtonTheme(
                                    minWidth: 60.0,
                                    height: 35.0,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        context.read<QuestionCubit>().compteur++;
                                        if (context.read<QuestionCubit>().compteur == 1) {
                                          context.read<QuestionCubit>().checkAnswer(
                                              false, context);
                                        }
                                      },
                                      child: const Text('FAUX'),
                                    ),
                                  ),
                                );

                            }),
                            BlocBuilder<QuestionCubit, QuestionState>(
                                builder: (context, container) {
                                return Padding(
                                  padding: EdgeInsets.all(20),
                                  child: ButtonTheme(
                                    minWidth: 60.0,
                                    height: 35.0,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (context.read<QuestionCubit>().compteur > 0 && context.read<QuestionCubit>().questionNum < context.read<QuestionCubit>().numberQuestions) {
                                          context.read<QuestionCubit>().compteur = 0;
                                          context.read<QuestionCubit>().nextQuestion();
                                        }

                                        if(context.read<QuestionCubit>().fini){

                                          Alert(
                                              context: context,
                                              title: "Fin du quizz",
                                              desc: "Votre score est : ${context.read<QuestionCubit>().total}/"
                                                  "${context.read<QuestionCubit>().numberQuestions} !",
                                              buttons: [
                                                DialogButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context);
                                                    },
                                                    child: const Text(
                                                        "Rejouer",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .white,
                                                            fontSize: 22)))]).show();

                                          context.read<QuestionCubit>().reset();

                                        }


                                      },
                                      child: const Icon(Icons.arrow_forward),
                                    ),
                                  ),
                                );

                            }),
                          ]),
                      BlocBuilder<QuestionCubit, QuestionState>(
                          builder: (context, state) {
                            return Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: context.read<QuestionCubit>().score,));
                          })
                    ]),
              ),
            );
          } else {
            return const CircularProgressIndicator(color: Colors.blue,);
          }
        });
  }
}
