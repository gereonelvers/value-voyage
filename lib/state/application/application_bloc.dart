import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../util/application_screen.dart';
import '../../util/route.dart';

part 'application_event.dart';

part 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationScreen currentScreen = ApplicationScreen.landing;
  String sessionID = "";

  List<String> cities = const ["Hamburg", "Berlin", "Munich"];
  List<NavigationRoute> routes = [];
  int selectedRoute = 0;

  double currentInsuranceValue = 2000;
  int selectedInsuranceCard = 0;
  TextEditingController originTextController = TextEditingController();
  TextEditingController destinationTextController = TextEditingController();
  DateTime time = DateTime.now();

  ApplicationBloc() : super(ApplicationInitial()) {
    sessionID = generateRandomString(10);
    on<ApplicationEvent>((event, emit) {});
    on<UpdateScreenEvent>((event, emit) {
      emit(ApplicationUpdating());
      emit(ApplicationInitial());
    });
  }

  // Using TextControllers for maintaining state is _aweful_ code style lmao
  getRoutes() async {
    final queryParameters = {
      'origin': originTextController.text,
      'destination': destinationTextController.text,
      'mode': "transit",
      'language': 'EN',
      'departure_time': (time.toUtc().millisecondsSinceEpoch ~/ 1000).toString(),
    };
    final uri = Uri.https('valuevoyageserver-production.up.railway.app', '/directions', queryParameters);
    final res = await http.get(uri);
    final parsed = jsonDecode(res.body);
    routes = (parsed['routes'] as List).map<NavigationRoute>((json) => NavigationRoute.fromJson(json)).toList();
    add(UpdateScreenEvent());
  }

  getMockRoutes() {
    routes = [
      NavigationRoute(
        arrivalTime: DateTime.now().add(const Duration(hours: 6)),
        departureTime: DateTime.now(),
        startAddress: "Hamburg Central Station",
        endAddress: "Munich Central Station",
        steps: [
          NavigationRouteStep(
              departureStop: "Hamburg Central Station",
              arrivalStop: "Berlin Central Station",
              departureTime: DateTime.now().add(const Duration(hours: 1, minutes: 5)),
              arrivalTime: DateTime.now().add(const Duration(hours: 6, minutes: 12)),
              agency: 'Deutsche Bahn',
              lineShortName: 'ICE518',
              punctuality: 0.95),
          NavigationRouteStep(
              departureStop: "Berlin Central Station",
              arrivalStop: "Munich Central Station",
              departureTime: DateTime.now().add(const Duration(hours: 2, minutes: 6)),
              arrivalTime: DateTime.now().add(const Duration(hours: 11, minutes: 26)),
              agency: 'Flixbus',
              lineShortName: 'N150',
              punctuality: 0.58),
        ],
      ),
      NavigationRoute(
        arrivalTime: DateTime.now().add(const Duration(hours: 6)),
        departureTime: DateTime.now(),
        startAddress: "Hamburg Central Station",
        endAddress: "Munich Central Station",
        steps: [
          NavigationRouteStep(
              departureStop: "Hamburg Central Station",
              arrivalStop: "Berlin Central Station",
              departureTime: DateTime.now().add(const Duration(hours: 1, minutes: 5)),
              arrivalTime: DateTime.now().add(const Duration(hours: 6, minutes: 12)),
              agency: 'Deutsche Bahn',
              lineShortName: 'ICE518',
              punctuality: 0.95),
          NavigationRouteStep(
              departureStop: "Berlin Central Station",
              arrivalStop: "Munich Central Station",
              departureTime: DateTime.now().add(const Duration(hours: 2, minutes: 6)),
              arrivalTime: DateTime.now().add(const Duration(hours: 11, minutes: 26)),
              agency: 'Flixbus',
              lineShortName: 'N150',
              punctuality: 0.58),
        ],
      ),
    ];
    add(UpdateScreenEvent());
  }

  autocomplete(String input) async {
    // https://maps.googleapis.com/maps/api/place/autocomplete/json?input=Goldacher+Stra&sessiontoken=placeholder
    final queryParameters = {'input': input, 'sessiontoken': sessionID, 'language': 'EN'};
    final uri = Uri.https('valuevoyageserver-production.up.railway.app', '/autocomplete', queryParameters);
    final res = await http.get(uri);
    print("Autocomplete:");
    print(res.statusCode);
    print(res.body);
  }

  String generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(List.generate(len, (index) => r.nextInt(33) + 89));
  }

  navigateTo(ApplicationScreen screen) {
    currentScreen = screen;
    add(UpdateScreenEvent());
  }
}
