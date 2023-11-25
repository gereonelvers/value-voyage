import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../util/trip_status.dart';
import '../widgets/logo.dart';
import '../widgets/plan_card.dart';
import '../widgets/trip_card.dart';
import '../widgets/trip_info.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool isBooking = false;
  FilePickerResult? selection;
  double _currentSliderValue = 2000;
  int _selectedCard = 0;

  _toggleBooking() {
    setState(() {
      isBooking = !isBooking;
    });
  }

  _onCardSelected(int index) {
    setState(() {
      _selectedCard = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6), BlendMode.darken),
              child: const Image(
                image: AssetImage("assets/img/background.jpg"),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              )),
          const Align(
            alignment: Alignment.topCenter,
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
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(20),
                          backgroundColor: Colors.green.shade800,
                          foregroundColor: Colors.greenAccent,
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(20),
                          backgroundColor: Colors.green.shade800,
                          foregroundColor: Colors.greenAccent,
                        ),
                        child: const Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Align(
            alignment: Alignment.centerLeft,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 470, maxWidth: 380),
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Card(
                  elevation: 4,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Your Trips",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      TripCard(
                        from: 'HH',
                        to: 'MUC',
                        status: TripStatus.onTime,
                        date: '21.11.2023',
                        timeRange: '18:30 - 21:14',
                      ),
                      TripCard(
                        from: 'MUC',
                        to: 'HH',
                        status: TripStatus.delayed,
                        date: '11.11.2023',
                        timeRange: '12:30 - 16:48',
                      ),
                      TripCard(
                        from: 'PMI',
                        to: 'MUC',
                        status: TripStatus.delayed,
                        date: '11.11.2023',
                        timeRange: '21:30 - 23:14',
                      ),
                      TripCard(
                        from: 'PMI',
                        to: 'MUC',
                        status: TripStatus.delayed,
                        date: '11.11.2023',
                        timeRange: '21:30 - 23:14',
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          isBooking
              ? Stack(
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
                              onTap: _toggleBooking,
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
                                              value: _currentSliderValue,
                                              max: 8000,
                                              min: 1000,
                                              divisions: 7,
                                              label:
                                                  "\$${_currentSliderValue.round()}",
                                              onChanged: (double value) {
                                                setState(() {
                                                  _currentSliderValue = value;
                                                });
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                const Text("Payout amount:"),
                                                Text(
                                                  "\$${_currentSliderValue.round()}",
                                                  style: const TextStyle(
                                                      fontSize: 24),
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
                                      padding:
                                          EdgeInsets.only(top: 8.0, left: 8.0),
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
                                          for (int index = 0;
                                              index < 3;
                                              index++)
                                            GestureDetector(
                                              onTap: () =>
                                                  _onCardSelected(index),
                                              child: PlanCard(
                                                title: [
                                                  "Basic",
                                                  "Plus",
                                                  "Premium"
                                                ][index],
                                                arrivalTime: [
                                                  "5h",
                                                  "2h",
                                                  "1h"
                                                ][index],
                                                isSelected:
                                                    _selectedCard == index,
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
                        padding:
                            const EdgeInsets.only(bottom: 64.0, right: 16.0),
                        child: SizedBox(
                          width: 250,
                          height: 200,
                          child: Card(
                              elevation: 4,
                              color: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Your Total",
                                      style: TextStyle(fontSize: 24),
                                    ),
                                    Text(
                                        "Basic plan covering \$$_currentSliderValue.........."),
                                    const Text(
                                        "Chance of delay: 18%..................."),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          // This will make the row take up all available horizontal space
                                          child: Container(
                                            alignment: Alignment
                                                .centerRight, // This aligns the text to the right
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0, top: 8.0),
                                              child: Text(
                                                "\$${(_currentSliderValue * ((_selectedCard + 1) * 0.02)).toInt() - 0.01}",
                                                style: const TextStyle(
                                                    fontSize:
                                                        22), // Add your desired styling for this text
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16, left: 8.0, right: 8.0),
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: Colors.green),
                                            borderRadius: BorderRadius.circular(
                                                10), // <-- Radius
                                          ),
                                        ),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 4.0),
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
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Text("Your timely journey starts here.",
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 48, color: Colors.white))),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 300),
                            child: Card(
                              elevation: 4,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          textInputAction:
                                              TextInputAction.search,
                                          onSubmitted: (value) {
                                            _toggleBooking();
                                          },
                                          decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText: 'Enter ride no.',
                                          ),
                                        ),
                                      ),
                                    ),
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                            color: Colors.green,
                                            child: IconButton(
                                                icon: const Icon(
                                                  Icons.arrow_right_alt,
                                                  color: Colors.white,
                                                ),
                                                onPressed: _toggleBooking)))
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
                      "ValueVoyage was created at TUM as part of the BPB seminar. No real insurance shall be provided.",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
