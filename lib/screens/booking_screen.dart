import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:value_voyage/util/application_screen.dart';

import '../state/application/application_bloc.dart';
import '../util/route.dart';
import '../util/utils.dart';
import '../widgets/plan_card.dart';
import '../widgets/trip_info.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({Key? key}) : super(key: key);

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
                      onPressed: () => applicationBloc.navigateTo(ApplicationScreen.selection),
                      icon: const Text("← Back"),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Your connection to ",
                              style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 32, color: Colors.black54)),
                            ),
                            Text(
                              applicationBloc.selectedRoute.endAddress,
                              style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 32, color: Colors.black54, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(12, 0, 6, 0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Theme.of(context).colorScheme.outline,
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                                ),
                                elevation: 0,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8, left: 24),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Itiniary",
                                          style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 24, color: Colors.black87)),
                                        ),
                                      ),
                                      ...generateTimeline(applicationBloc),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(6, 0, 12, 0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Theme.of(context).colorScheme.outline,
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                                ),
                                elevation: 0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8, left: 8),
                                      child: Text(
                                        "Fact Sheet",
                                        style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 24, color: Colors.black87)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12.0, top: 2, bottom: 2),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.date_range),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 4.0),
                                            child: Text("Your trip is on ${DateFormat("dd.MM.yyyy").format(applicationBloc.selectedRoute.departureTime)}."),
                                          ),
                                          //Text("${DateFormat("hh:mm a").format(departureTime)} - ${DateFormat("hh:mm a").format(arrivalTime)} | ${Utils.formatDuration(arrivalTime.difference(departureTime))}")
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12.0, top: 2, bottom: 2),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.access_time),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 4.0),
                                            child: Text(
                                                "Your first connection leaves at ${DateFormat("hh:mm a").format(applicationBloc.selectedRoute.departureTime)} from ${applicationBloc.selectedRoute.startAddress}."),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12.0, top: 2, bottom: 2),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.business_center_rounded),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 4.0),
                                            child: Text(
                                                "The likelihood of arriving on time is approximately ${Utils.doubleToPercent(applicationBloc.selectedRoute.totalPunctuality)}"),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0, top: 32),
                                      child: Text(
                                        "Insurance",
                                        style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 24, color: Colors.black87)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 200,
                                            width: 800,
                                            child: GridView.count(
                                              shrinkWrap: true,
                                              primary: false,
                                              scrollDirection: Axis.horizontal,
                                              padding: const EdgeInsets.all(20),
                                              crossAxisSpacing: 0,
                                              mainAxisSpacing: 5,
                                              childAspectRatio: 15 / 23,
                                              crossAxisCount: 1,
                                              children: [
                                                for (int index = 0; index < 3; index++)
                                                  GestureDetector(
                                                    onTap: () {
                                                      applicationBloc.selectedInsuranceCard = index;
                                                      applicationBloc.add(UpdateScreenEvent());
                                                    },
                                                    child: PlanCard(
                                                      title: ["Basic", "Plus", "Premium"][index],
                                                      iconOne: [
                                                        const Icon(Icons.not_interested),
                                                        const Icon(Icons.check_circle_outline_rounded),
                                                        const Icon(Icons.check_circle_outline_rounded)
                                                      ][index],
                                                      featureOne: ["No Coverage", "Full Trip Coverage", "Full Trip Coverage"][index],
                                                      iconTwo: [
                                                        const Icon(Icons.not_interested),
                                                        const Icon(Icons.check_circle_outline_rounded),
                                                        const Icon(Icons.check_circle_outline_rounded)
                                                      ][index],
                                                      featureTwo: ["No Arrival Guarantee", "Arrival with 2h", "Arrival within 1h"][index],
                                                      isSelected: applicationBloc.selectedInsuranceCard == index,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "Price",
                                        style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 24, color: Colors.black87)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text("Trip Fare: ${Utils.doubleToPrice(applicationBloc.selectedRoute.fare)}"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                          "Insurance Premium: ${Utils.doubleToPrice(applicationBloc.currentInsuranceValue * ((applicationBloc.selectedInsuranceCard) * 0.02))}"),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          // This will make the row take up all available horizontal space
                                          child: Container(
                                            alignment: Alignment.centerRight, // This aligns the text to the right
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 8.0, top: 8.0, bottom: 12),
                                              child: Text(
                                                "Total: ${Utils.doubleToPrice(applicationBloc.selectedRoute.fare + applicationBloc.currentInsuranceValue * ((applicationBloc.selectedInsuranceCard) * 0.02))}",
                                                style: const TextStyle(fontSize: 22), // Add your desired styling for this text
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                          padding: const EdgeInsets.all(14),
                                          backgroundColor: Colors.green.shade600,
                                          foregroundColor: Colors.greenAccent,
                                        ),
                                        onPressed: () {
                                          Utils.showToast(context, "Error", "For demonstration purposes only.");
                                        },
                                        child: const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("💳 Book", style: TextStyle(color: Colors.white),),
                                          ],
                                        ),
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
              ],
            )),
      );
    });
  }

  generateTimeline(ApplicationBloc bloc) {
    List<Widget> tiles = [];
    for (NavigationRouteStep step in bloc.selectedRoute.steps) {
      // Add stop
      tiles.add(TimelineTile(
        axis: TimelineAxis.vertical,
        alignment: TimelineAlign.start,
        isFirst: tiles.isEmpty,
        endChild: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(step.departureStop, style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 20, color: Colors.black54))),
        ),
      ));
      // Add travel
      tiles.add(Padding(
        padding: const EdgeInsets.only(left: 11.0),
        child: TimelineTile(
          axis: TimelineAxis.vertical,
          alignment: TimelineAlign.start,
          hasIndicator: false,
          endChild: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${DateFormat("hh:mm a").format(step.departureTime)} - ${DateFormat("hh:mm a").format(step.arrivalTime)}",
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    (step.agency).contains("Flixbus")
                        ? const Padding(
                            padding: EdgeInsets.only(top: 8.0, right: 4),
                            child: Image(image: AssetImage("assets/img/flix-logo.png"), height: 21),
                          )
                        : const Padding(
                            padding: EdgeInsets.only(top: 8.0, right: 4),
                            child: Image(image: AssetImage("assets/img/db-logo.png"), height: 21),
                          ),
                    Text(
                      step.lineShortName,
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "Punctual ${Utils.doubleToPercent(step.punctuality)} of the time.",
                    style: TextStyle(color: Utils.punctualityColor(step.punctuality)),
                  ),
                )
              ],
            ),
          ),
        ),
      ));
      // Add last tile
      if (tiles.length == bloc.selectedRoute.steps.length * 2) {
        tiles.add(TimelineTile(
          axis: TimelineAxis.vertical,
          alignment: TimelineAlign.start,
          isLast: true,
          endChild: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(step.arrivalStop, style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 20, color: Colors.black54))),
          ),
        ));
      }
    }
    return tiles;
  }
}
