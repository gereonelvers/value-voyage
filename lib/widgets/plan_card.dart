import 'package:flutter/material.dart';

class PlanCard extends StatelessWidget {
  final String title;
  final Icon iconOne;
  final String featureOne;
  final Icon iconTwo;
  final String featureTwo;
  final bool isSelected;

  const PlanCard(
      {super.key,
      required this.title,
      required this.iconOne,
      required this.featureOne,
      required this.iconTwo,
      required this.featureTwo,
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
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 6),
                child: iconOne,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  featureOne,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 6),
                child: iconTwo,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  featureTwo,
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
