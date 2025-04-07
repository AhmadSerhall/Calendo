// Callback to add a new event to the map
import 'package:admin/app/data.dart';
import 'package:admin/features/home/data/providers/events_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void addNewEvent(Map<String, String> newEvent) {
  final parts = newEvent["date"]!.split("-");
  final y = int.parse(parts[0]);
  final m = int.parse(parts[1]);
  final d = int.parse(parts[2]);

  final dayKey = DateTime(y, m, d);

  globalRef!.read(eventsProvider).putIfAbsent(dayKey, () => []);
  globalRef!.read(eventsProvider)[dayKey]!.add(newEvent);
}
