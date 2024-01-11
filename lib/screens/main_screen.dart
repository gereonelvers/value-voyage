import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:value_voyage/screens/booking_screen.dart';
import 'package:value_voyage/screens/landing_screen.dart';
import 'package:value_voyage/screens/selection_screen.dart';
import 'package:value_voyage/util/application_screen.dart';

import '../state/application/application_bloc.dart';
import '../widgets/logo.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApplicationBloc applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    return BlocBuilder<ApplicationBloc, ApplicationState>(
      // buildWhen: (previous, current) => previous != current && current is ApplicationUpdating,
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              ColorFiltered(
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
                  child: const Image(
                    image: AssetImage("assets/img/background.jpg"),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  )),
              const Align(
                alignment: Alignment.topLeft,
                child: Logo(),
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.all(14),
                              backgroundColor: Colors.green.shade600,
                              foregroundColor: Colors.greenAccent,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 6.0),
                                  child: Text(
                                    "Login",
                                    style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 14, color: Colors.white)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Column(
                children: [
                  if (applicationBloc.currentScreen == ApplicationScreen.landing)
                    SizedBox(height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width, child: const LandingScreen())
                  else if (applicationBloc.currentScreen == ApplicationScreen.selection)
                    SizedBox(height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width, child: const SelectionScreen())
                  else if (applicationBloc.currentScreen == ApplicationScreen.booking)
                    SizedBox(height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width, child: const BookingScreen())
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
