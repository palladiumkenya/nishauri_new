import 'package:flutter/material.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/logger.dart';

class LogItems {
  static List<Logger> getSymptoms() {
    Color symptomsColor = Colors.pink;
    return [
      Logger(
        icon: Icons.favorite,
        label: 'Cramps',
        color: symptomsColor,
      ),
      Logger(
        icon: Icons.sentiment_satisfied,
        label: 'Mood swings',
        color: symptomsColor,
      ),
      Logger(
        icon: Icons.battery_alert,
        label: 'Fatigue',
        color: symptomsColor,
      ),
      // Add more symptom loggers as needed
    ];
  }

  static List<Logger> getDischarge() {
    Color dischargeColor = Colors.blue;
    return [
      Logger(
        icon: Icons.water_drop,
        label: 'No discharge',
        color: dischargeColor,
      ),
      Logger(
        icon: Icons.water_drop,
        label: 'Egg whites',
        color: dischargeColor,
      ),
      Logger(
        icon: Icons.water_drop,
        label: 'Sticky',
        color: dischargeColor,
      ),
      Logger(
        icon: Icons.water_drop,
        label: 'Brown',
        color: dischargeColor,
      ),
      Logger(
        icon: Icons.water_drop,
        label: 'Yellow or Green',
        color: dischargeColor,
      ),
      // Add more discharge loggers as needed
    ];
  }

  static List<Logger> getMoods() {
    Color moodsColor = Colors.orange;
    return [
      Logger(
        icon: Icons.sentiment_very_satisfied,
        label: 'Happy',
        color: moodsColor,
      ),
      Logger(
        icon: Icons.sentiment_dissatisfied,
        label: 'Sad',
        color: moodsColor,
      ),
      Logger(
        icon: Icons.sentiment_neutral,
        label: 'Anxious',
        color: moodsColor,
      ),
      // Add more mood loggers as needed
    ];
  }
}
