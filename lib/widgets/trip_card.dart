import 'package:flutter/material.dart';

import '../util/trip_status.dart';

class TripCard extends StatelessWidget {
  final String from;
  final String to;
  final TripStatus status;
  final String date;
  final String timeRange;

  const TripCard({
    super.key,
    required this.from,
    required this.to,
    required this.status,
    required this.date,
    required this.timeRange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card wrap its content
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '$from → $to', // Using a unicode arrow
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10), // Add spacing
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    status == TripStatus.onTime ? 'ON TIME' : 'DELAYED',
                    style: TextStyle(
                      fontSize: 12,
                      color: status == TripStatus.onTime
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  Text(
                    timeRange,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
