import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/application/application_bloc.dart';
import '../util/application_screen.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApplicationBloc applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    return BlocBuilder<ApplicationBloc, ApplicationState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(64, 96, 64, 32),
        child: Card(
          color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(onPressed: (){
                        applicationBloc.currentScreen = ApplicationScreen.landing;
                        applicationBloc.add(UpdateScreenEvent());
                      }, icon: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 6.0),
                            child: Icon(Icons.arrow_back_rounded),
                          ),
                          Text("Zurück")
                        ],
                      ),),
                    ),
                  ],
                ),
              ],
            )),
      );
    });
  }
}
