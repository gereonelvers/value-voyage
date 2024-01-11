import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:value_voyage/util/application_screen.dart';
import 'package:intl/intl.dart';


import '../state/application/application_bloc.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ApplicationBloc applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    return BlocBuilder<ApplicationBloc, ApplicationState>(
        buildWhen: (previous, current) => previous != current && current is ApplicationUpdating,
        builder: (context, state) {
          return Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: DefaultTextStyle(
                          style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 48, color: Colors.white)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Make your journey "),
                            Stack(
                              children: [
                                const Center(
                                  child: SizedBox(height: 100, width: 300,),
                                ),
                                Center(
                                  child: AnimatedTextKit(
                                    pause: Duration(milliseconds: 0),
                                    repeatForever: true,
                                    animatedTexts: [
                                      RotateAnimatedText('steady 🛡️'),
                                      RotateAnimatedText('awesome 😎'),
                                      RotateAnimatedText('timely ⏱️'),
                                      RotateAnimatedText('swift 🛠️ '),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 600),
                          child: Card(
                            elevation: 4,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextField(
                                                  textInputAction: TextInputAction.search,
                                                  controller: applicationBloc.startTextController,
                                                  onSubmitted: (value) {
                                                    applicationBloc.currentScreen = ApplicationScreen.selection;
                                                    applicationBloc.add(UpdateScreenEvent());
                                                  },
                                                  decoration: const InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    labelText: 'From',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextField(
                                                  textInputAction: TextInputAction.search,
                                                  controller: applicationBloc.originTextController,
                                                  onSubmitted: (value) {
                                                    applicationBloc.currentScreen = ApplicationScreen.selection;
                                                    applicationBloc.add(UpdateScreenEvent());
                                                  },
                                                  decoration: const InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    labelText: 'To',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            textInputAction: TextInputAction.search,
                                            controller: applicationBloc.timeTextController,
                                            onSubmitted: (value) {
                                              applicationBloc.currentScreen = ApplicationScreen.selection;
                                              applicationBloc.add(UpdateScreenEvent());
                                            },
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'On',
                                            ),
                                            onTap: () async {
                                              applicationBloc.time = await showOmniDateTimePicker(
                                                      context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 90))) ??
                                                  DateTime.now();
                                              applicationBloc.timeTextController.text = DateFormat("dd.mm.yyyy 'after' kk:mm (cccc)").format(applicationBloc.time);
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(64, 0, 64, 0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Container(
                                                color: Colors.green,
                                                child: IconButton(
                                                    icon: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        const Padding(
                                                          padding: EdgeInsets.only(right: 6.0),
                                                          child: Icon(
                                                            Icons.search,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          "Search",
                                                          style: GoogleFonts.inter(textStyle: const TextStyle(color: Colors.white, fontSize: 16)),
                                                        ),
                                                      ],
                                                    ),
                                                    onPressed: () {
                                                      applicationBloc.currentScreen = ApplicationScreen.selection;
                                                      applicationBloc.add(UpdateScreenEvent());
                                                    })),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.grey.shade800.withAlpha(120),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "ValueVoyage was created at TUM as part of the BPG seminar. No real insurance shall be provided.",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
}
