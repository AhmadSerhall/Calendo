import 'package:flutter_riverpod/flutter_riverpod.dart';

var eventsProvider = StateProvider<Map<DateTime, List<Map<String, String>>>>(
  (_) => {
    DateTime(2025, 4, 5): [
      {
        "name": "Design new UX flow for Michael",
        "phone": "N/A",
        "note": "Start from screen 16",
        "date": "2025-04-05",
        "start": "10:00",
        "end": "13:00",
        "priority": "false",
        "color": "green",
      },
      {
        "name": "Brainstorm with the team",
        "phone": "N/A",
        "note": "Define the problem or question that...",
        "date": "2025-04-05",
        "start": "14:00",
        "end": "15:00",
        "priority": "false",
        "color": "purple",
      },
      {
        "name": "Workout with Ella",
        "phone": "N/A",
        "note": "We will do the legs and back workout",
        "date": "2025-04-05",
        "start": "19:00",
        "end": "20:00",
        "priority": "false",
        "color": "blue",
      },
    ],
  },
);
