import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../state/application/application_bloc.dart';
import '../util/application_screen.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApplicationBloc applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    return BlocBuilder<ApplicationBloc, ApplicationState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(128, 70, 128, 32),
        child: Card(
            color: const Color(0xfff1fffb),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () => applicationBloc.navigateTo(ApplicationScreen.landing),
                      icon: const Text("← Back"),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      DefaultTextStyle(
                        style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 32, color: Colors.black54)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(256, 24, 256, 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Connections from "),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                    onTap: () => applicationBloc.navigateTo(ApplicationScreen.landing),
                                    child: Text(
                                      applicationBloc.originTextController.text,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    )),
                              ),
                              const Text(" to "),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                    onTap: () => applicationBloc.navigateTo(ApplicationScreen.landing),
                                    child: Text(
                                      applicationBloc.destinationTextController.text,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    )),
                              ),
                              const Text(" on "),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                    onTap: () => applicationBloc.navigateTo(ApplicationScreen.landing),
                                    child: Text(
                                      DateFormat("dd.MM.yy 'after' hh:mm a").format(applicationBloc.time),
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      applicationBloc.routes.isEmpty
                          ? const Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.all(32.0),
                                child: CircularProgressIndicator(),
                              ))
                          : Expanded(
                              child: Padding(
                              padding: const EdgeInsets.only(left: 196, right: 196),
                              child: GridView.count(
                                  physics: const ScrollPhysics(),
                                  shrinkWrap: true,
                                  childAspectRatio: 18 / 3,
                                  crossAxisCount: 1,
                                  children: applicationBloc.routes),
                            ))
                    ],
                  ),
                ),
              ],
            )),
      );
    });
  }
}
