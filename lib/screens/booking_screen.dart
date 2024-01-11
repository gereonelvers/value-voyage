import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_voyage/util/application_screen.dart';

import '../state/application/application_bloc.dart';
import '../widgets/plan_card.dart';
import '../widgets/trip_info.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApplicationBloc applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    return BlocBuilder<ApplicationBloc, ApplicationState>(builder: (context, state) {
      return Stack(
        children: [
          Center(
              child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      applicationBloc.currentScreen = ApplicationScreen.landing;
                      applicationBloc.add(UpdateScreenEvent());
                    },
                    child: const Row(
                      children: [
                        Text(
                          "← Back",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                const TripInfo(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      elevation: 4,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Insurance Amount",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                const Text("\$1000"),
                                Expanded(
                                  child: Slider(
                                    value: applicationBloc.currentInsuranceValue,
                                    max: 8000,
                                    min: 1000,
                                    divisions: 7,
                                    label: "\$${applicationBloc.currentInsuranceValue.round()}",
                                    onChanged: (double value) {
                                      applicationBloc.currentInsuranceValue = value;
                                      applicationBloc.add(UpdateScreenEvent());
                                    },
                                  ),
                                ),
                                const Text("\$8000"),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text("Payout amount:"),
                                      Text(
                                        "\$${applicationBloc.currentInsuranceValue.round()}",
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      elevation: 4,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0, left: 8.0),
                            child: Text(
                              "Your Coverage",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          SizedBox(
                            height: 200,
                            width: 700,
                            child: GridView.count(
                              shrinkWrap: true,
                              primary: false,
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.all(20),
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 5,
                              childAspectRatio: 18 / 23,
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
                                      arrivalTime: ["5h", "2h", "1h"][index],
                                      isSelected: applicationBloc.selectedInsuranceCard == index,
                                    ),
                                  ),
                              ],
                            ),
                          )
                        ],
                      )),
                ),
              ],
            ),
          )),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 64.0, right: 16.0),
              child: SizedBox(
                width: 250,
                height: 200,
                child: Card(
                    elevation: 4,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Your Total",
                            style: TextStyle(fontSize: 24),
                          ),
                          Text("Basic plan covering \$${applicationBloc.currentInsuranceValue}.........."),
                          const Text("Chance of delay: 18%..................."),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                // This will make the row take up all available horizontal space
                                child: Container(
                                  alignment: Alignment.centerRight, // This aligns the text to the right
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                                    child: Text(
                                      "\$${(applicationBloc.currentInsuranceValue * ((applicationBloc.selectedInsuranceCard + 1) * 0.02)).toInt() - 0.01}",
                                      style: const TextStyle(fontSize: 22), // Add your desired styling for this text
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16, left: 8.0, right: 8.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.green),
                                  borderRadius: BorderRadius.circular(10), // <-- Radius
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 4.0),
                                    child: Icon(Icons.payment),
                                  ),
                                  Text(
                                    "Pay now",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            ),
          )
        ],
      );
    });
  }
}
