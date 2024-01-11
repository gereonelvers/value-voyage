import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../util/application_screen.dart';

part 'application_event.dart';
part 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationScreen currentScreen = ApplicationScreen.landing;
  double currentInsuranceValue = 2000;
  int selectedInsuranceCard = 0;
  TextEditingController startTextController = TextEditingController();
  TextEditingController originTextController = TextEditingController();
  TextEditingController timeTextController = TextEditingController();
  String origin = "Hamburg";
  String destination = "München";
  DateTime time = DateTime.now();

  ApplicationBloc() : super(ApplicationInitial()) {
    on<ApplicationEvent>((event, emit) {
    });
    on<UpdateScreenEvent>((event, emit) {
      emit(ApplicationUpdating());
      emit(ApplicationInitial());
    });
  }
}
