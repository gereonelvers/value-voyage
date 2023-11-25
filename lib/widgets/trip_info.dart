import 'package:flutter/material.dart';

class TripInfo extends StatelessWidget {
  const TripInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          elevation: 4,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Trip",
                      style: TextStyle(fontSize: 24),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        "From Munich Hbf to Hamburg Hbf (#12345)",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "21.11.",
                          style: TextStyle(fontSize: 24),
                        ),
                        Text(
                          "18:30 - 21:14",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const VerticalDivider(
                    width: 20,
                    thickness: 2,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                            color: Colors.green,
                            child: IconButton(
                              icon: const Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ))),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
