import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:value_voyage/screens/main_screen.dart';
import 'package:value_voyage/state/application/application_bloc.dart';

void main() => runApp(const ValueVoyage());

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

class ValueVoyage extends StatelessWidget {
  const ValueVoyage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ValueVoyage',
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      //home: const LandingScreen(),
      home: Scaffold(
        body: BlocProvider(
          create: (context) => ApplicationBloc(),
          child: const MainScreen(),
        ),
      ),
    );
  }
}
