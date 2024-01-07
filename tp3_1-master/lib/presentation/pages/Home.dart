import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../buisness_logic/cubits/ViewCubit.dart';
import '../../data/dataproviders/Questionprovider.dart';
import '../widgets/DropdownThemes.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final QuestionProvider _provider = QuestionProvider();

  @override
  Widget build(BuildContext context) {
    return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 70, top: 5,left: 50, right: 50),
                  child: Image.asset("images/quizz.jpg", width: 700,
                    height: 200,
                    fit: BoxFit.fill,),
                ),

                const Text(
                  'TP3',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 3,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Choix catégorie :',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                    color: Colors.black,
                  ),
                ),
                FutureBuilder<List<String>>(
                    future: _provider.getThematics(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Une erreur est survenue..');
                      } else if (snapshot.hasData) {
                        return Dropdown(thematics: snapshot.data!);
                      } else {
                        //return const Text('Chargement en cours...');
                        return CircularProgressIndicator(color: Colors.blue,);
                      }
                    }),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<ViewCubit>().setValue('quiz');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text('Lancer un quiz'),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue
                  ),
                  onPressed: () {
                    context.read<ViewCubit>().setValue('form');
                  },
                  child: const Text('Ajouter une question'),
                ),
              ],
    );
  }
}

