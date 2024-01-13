import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:value_voyage/util/application_screen.dart';

import '../state/application/application_bloc.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ApplicationBloc applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: ()=> applicationBloc.navigateTo(ApplicationScreen.landing),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Image(image: AssetImage("assets/img/logo.png"), height: 48),
              ),
              Text(
                "ValueVoyage",
                style: GoogleFonts.inter(
                    fontSize: 24, fontWeight: FontWeight.w600, color: Colors.green.shade50),
              )
            ],
          ),
        ),
      ),
    );
  }
}
