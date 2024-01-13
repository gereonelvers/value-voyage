import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:value_voyage/util/application_screen.dart';
import 'package:value_voyage/util/utils.dart';

import '../state/application/application_bloc.dart';

class NavigationRoute extends StatelessWidget {
  final DateTime arrivalTime;
  final DateTime departureTime;
  final String startAddress;
  final String endAddress;
  final double fare;
  final List<NavigationRouteStep> steps;

  const NavigationRoute({
    super.key,
    required this.arrivalTime,
    required this.departureTime,
    required this.startAddress,
    required this.endAddress,
    required this.fare,
    required this.steps,
  });

  factory NavigationRoute.fromJson(Map<String, dynamic> json) {
    var legs = json['legs'][0];
    return NavigationRoute(
      arrivalTime: DateTime.fromMillisecondsSinceEpoch(legs['arrival_time']['value'] * 1000),
      departureTime: DateTime.fromMillisecondsSinceEpoch(legs['departure_time']['value'] * 1000),
      startAddress: legs['start_address'],
      endAddress: legs['end_address'],
      fare: (json['fare'] ?? {"value": 0})['value'],
      steps: (legs['steps'] as List).map((step) => NavigationRouteStep.fromJson(step)).toList(), // TODO
      // steps: [
      //   NavigationRouteStep(
      //       departureStop: "Hamburg Central Station",
      //       arrivalStop: "Berlin Central Station",
      //       departureTime: DateTime.now().add(const Duration(hours: 1, minutes: 5)),
      //       arrivalTime: DateTime.now().add(const Duration(hours: 6, minutes: 12)),
      //       agency: 'Deutsche Bahn',
      //       lineShortName: 'ICE518',
      //       punctuality: 0.95),
      //   NavigationRouteStep(
      //       departureStop: "Berlin Central Station",
      //       arrivalStop: "Munich Central Station",
      //       departureTime: DateTime.now().add(const Duration(hours: 2, minutes: 6)),
      //       arrivalTime: DateTime.now().add(const Duration(hours: 11, minutes: 26)),
      //       agency: 'Flixbus',
      //       lineShortName: 'N150',
      //       punctuality: 0.58),
      // ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ApplicationBloc applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    return SizedBox(
      height: 250,
      width: 500,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(64, 4, 64, 4),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          elevation: 0,
          child: InkWell(
            onTap: () {
              applicationBloc.selectedRoute = this;
              applicationBloc.navigateTo(ApplicationScreen.booking);
            },
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "${DateFormat("hh:mm a").format(departureTime)} - ${DateFormat("hh:mm a").format(arrivalTime)} | ${Utils.formatDuration(arrivalTime.difference(departureTime))}",
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      )),
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: generateTimeline(),
                          ),
                        )),
                    const VerticalDivider(
                      color: Colors.black,
                      width: 5,
                    ),
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(24, 4, 24, 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Punctuality", style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 16, color: Colors.black45))),
                              Text(Utils.doubleToPercent(totalPunctuality),
                                  style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 26, color: Colors.black45))),
                              const SizedBox(height: 8),
                              Text("Total price", style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 16, color: Colors.black45))),
                              Text(Utils.doubleToPrice(fare), style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 26, color: Colors.black45))),
                            ],
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  generateTimeline() {
    List<Widget> tiles = [];
    var stepsSubset = steps;
    if (steps.length>3) {
      stepsSubset = [steps[0], steps[steps.length-1]];
    }
    for (NavigationRouteStep step in stepsSubset) {
      // Add stop
      tiles.add(TimelineTile(
        axis: TimelineAxis.horizontal,
        alignment: TimelineAlign.center,
        isFirst: tiles.isEmpty,
        endChild: Text(step.departureStop, style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 16, color: Colors.black87))),
      ));
      // Add travel
      tiles.add(Expanded(
        child: TimelineTile(
          axis: TimelineAxis.horizontal,
          alignment: TimelineAlign.center,
          hasIndicator: false,
          startChild: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("${DateFormat("hh:mma").format(step.departureTime)} - ${DateFormat("hh:mma").format(step.arrivalTime)}",
                  style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 16, color: Colors.black87))),
            ],
          ),
          endChild: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  Container(
                    decoration: BoxDecoration(border: Border.all(color: Utils.punctualityColor(step.punctuality)), borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      "${(step.punctuality * 100).toInt()}%",
                      style: TextStyle(color: Utils.punctualityColor(step.punctuality)),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ));
      // Add last tile
      if (tiles.length == steps.length * 2) {
        tiles.add(TimelineTile(
          axis: TimelineAxis.horizontal,
          alignment: TimelineAlign.center,
          isLast: true,
          endChild: Text(step.arrivalStop, style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 16, color: Colors.black87))),
        ));
      }
    }
    return tiles;
  }

  double get totalPunctuality {
    double punctuality = 1;
    for (NavigationRouteStep step in steps) {
      punctuality *= step.punctuality;
    }
    return punctuality;
  }
}

class NavigationRouteStep {
  final String departureStop;
  final String arrivalStop;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final String agency;
  final String lineShortName;
  final double punctuality;

  NavigationRouteStep(
      {required this.departureStop,
      required this.arrivalStop,
      required this.departureTime,
      required this.arrivalTime,
      required this.agency,
      required this.lineShortName,
      required this.punctuality});

  // this is stupid lol
  factory NavigationRouteStep.fromJson(Map<String, dynamic> json) {
    var transitDetails = json['transit_details'];
    var rng = Random();

    String departureStop = "";
    try {
      departureStop = transitDetails['departure_stop']['name'];
    } catch (exception) {
      departureStop = "N/A";
    }

    String arrivalStop = "";
    try {
      arrivalStop = transitDetails['arrival_stop']['name'];
    } catch (exception) {
      arrivalStop = "N/A";
    }

    DateTime departureTime = DateTime.now();
    try {
      departureTime = DateTime.fromMillisecondsSinceEpoch(transitDetails['departure_time']['value'] * 1000);
    } catch (exception) {
      departureTime = DateTime.now();
    }

    DateTime arrivalTime = DateTime.now();
    try {
      arrivalTime = DateTime.fromMillisecondsSinceEpoch(transitDetails['arrival_time']['value'] * 1000);
    } catch (exception) {
      arrivalTime = DateTime.now();
    }

    String agencyName = "";
    try {
      agencyName = transitDetails['line']['agencies'][0]['name'];
    } catch (exception) {
      agencyName = "N/A";
    }

    String lineShortName = "";
    try {
      lineShortName = transitDetails['line']['short_name'];
    } catch (exception) {
      lineShortName = "N/A";
    }

    return NavigationRouteStep(
        departureStop: departureStop,
        arrivalStop: arrivalStop,
        departureTime: departureTime,
        arrivalTime: arrivalTime,
        agency: agencyName.contains('FlixBus') ? 'FlixBus' : 'Deutsche Bahn',
        lineShortName: lineShortName,
        punctuality: 0.10 + rng.nextDouble() * 0.89);
  }
}
