import 'dart:math';

import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class Utils {
  static String formatDuration(Duration duration) {
    int minutes = duration.inMinutes + (duration.inSeconds.remainder(60) >= 30 ? 1 : 0);
    int hours = minutes ~/ 60; // Calculate hours, taking into account the rounded minutes
    minutes = minutes.remainder(60); // Get the remainder minutes
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(hours)}h ${twoDigits(minutes)}min";
  }

  static Color punctualityColor(double punctuality) {
    switch (punctuality) {
      case < 0.3:
        return Colors.red.shade800;
      case < 0.5:
        return Colors.orange.shade800;
      case < 0.7:
        return Colors.yellow.shade800;
      default:
        return Colors.green.shade800;
    }
  }

  static String randomString(int len) {
    var r = Random();
    return String.fromCharCodes(List.generate(len, (index) => r.nextInt(33) + 89));
  }

  static showToast(BuildContext context, String title, String description) {
    MotionToast(
      icon: Icons.error_outline,
      displaySideBar: false,
      primaryColor: Colors.red,
      title: Text(title),
      description: Text(description),
      position: MotionToastPosition.bottom,
      animationType: AnimationType.fromBottom,
      animationCurve: Curves.bounceOut,
      animationDuration: const Duration(milliseconds: 250),
      toastDuration: const Duration(seconds: 2),
    ).show(context);
  }

  static doubleToPrice(double price) {
    if (price<=0) {
      return "N/A";
    }
    return "${price.toStringAsFixed(2)}€";
  }

  static doubleToPercent(double punctuality) => "${(punctuality*100).toStringAsFixed(2)}%";

}
