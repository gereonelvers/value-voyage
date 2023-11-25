import 'package:flutter/material.dart';

class PlanCard extends StatelessWidget {
  final String title;
  final String arrivalTime;
  final bool isSelected;

  const PlanCard(
      {super.key,
      required this.title,
      required this.arrivalTime,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 12.0 : 0.0,
      color: isSelected ? Colors.green.shade100 : Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 12.0, right: 6),
                child: Icon(Icons.check_circle_outline_rounded),
              ),
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: Text(
                  "Full trip coverage",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 12.0, right: 6),
                child: Icon(Icons.check_circle_outline_rounded),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  "Arrival within $arrivalTime",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 28,
          )
        ],
      ),
    );
  }
}
