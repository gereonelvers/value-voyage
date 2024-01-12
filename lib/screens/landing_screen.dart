import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
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
                      padding: const EdgeInsets.all(24.0),
                      child: DefaultTextStyle(
                        style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 48, color: Colors.white)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 40.0),
                              child: Text("Make your journey "),
                            ),
                            Stack(
                              children: [
                                const Center(
                                  child: SizedBox(
                                    height: 200,
                                    width: 300,
                                  ),
                                ),
                                Center(
                                  child: AnimatedTextKit(
                                    pause: const Duration(milliseconds: 0),
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
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 700),
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
                                              controller: applicationBloc.originTextController,
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
                                              controller: applicationBloc.destinationTextController,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'To',
                                              ),
                                              onSubmitted: (value) async => submit(applicationBloc, context),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: GestureDetector(
                                            onTap: () async => showDateTimePicker(applicationBloc, context),
                                            child: Row(
                                              children: [
                                                const Icon(Icons.calendar_month, size: 22),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4),
                                                  child: Text(
                                                    DateFormat("dd.MM, hh:mm a").format(applicationBloc.time),
                                                    style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 16)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(64, 8, 64, 0),
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
                                              onPressed: () async => submit(applicationBloc, context),
                                            )),
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
                          "ValueVoyage was created at TUM as part of the BPG seminar. No real product or service shall be provided.",
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

  // oof ugly
  showDateTimePicker(ApplicationBloc bloc, BuildContext context) async {
    bloc.time = await showOmniDateTimePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 90)),
            isForce2Digits: true,
            minutesInterval: 5) ??
        DateTime.now();
    bloc.add(UpdateScreenEvent());
  }

  submit(ApplicationBloc bloc, BuildContext context) async {
    bloc.getMockRoutes();
    if (bloc.originTextController.text != "" && bloc.destinationTextController.text != "") {
      bloc.currentScreen = ApplicationScreen.selection;
      bloc.add(UpdateScreenEvent());
    } else {
      MotionToast(
        icon: Icons.error_outline,
        displaySideBar: false,
        primaryColor: Colors.red,
        title: const Text("Error"),
        description: const Text("Please fill out all fields."),
        position: MotionToastPosition.bottom,
        animationType: AnimationType.fromBottom,
        animationCurve: Curves.bounceOut,
        animationDuration: const Duration(milliseconds: 250),
        toastDuration: const Duration(seconds: 2),
      ).show(context);
    }
  }
}
