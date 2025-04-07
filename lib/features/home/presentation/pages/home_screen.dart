import 'package:admin/core/dialogs/alert.dart';
import 'package:admin/features/home/data/functions/events_functions.dart';
import 'package:admin/features/home/data/providers/events_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import '../components/add_event_sheet.dart';
import 'package:admin/core/constants/colors.dart'; // for 'blue' color

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  // Return events for a given day
  List<Map<String, String>> _getEventsForDay(DateTime day) {
    final dayKey = DateTime(day.year, day.month, day.day);
    return ref.watch(eventsProvider)[dayKey] ?? [];
  }

  // Show bottom sheet in "Add" mode
  void _showAddEventBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      builder: (_) {
        return const AddEventSheet(
          onSave: addNewEvent, // callback
          isEdit: false,
        );
      },
    );
  }

  // Show bottom sheet in "Edit" mode
  void _showEditEventBottomSheet(Map<String, String> existingEvent, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      builder: (_) {
        return AddEventSheet(
          onSave: (updatedEvent) => _updateEvent(updatedEvent, index),
          isEdit: true,
          existingEvent: existingEvent,
        );
      },
    );
  }

  // Callback to update an existing event
  void _updateEvent(Map<String, String> updatedEvent, int index) {
    final parts = updatedEvent["date"]!.split("-");
    final y = int.parse(parts[0]);
    final m = int.parse(parts[1]);
    final d = int.parse(parts[2]);
    final dayKey = DateTime(y, m, d);

    setState(() {
      // remove from old dayKey if date changed
      DateTime? oldKey;
      for (var key in ref.read(eventsProvider).keys) {
        final list = ref.read(eventsProvider)[key];
        if (list != null) {
          final idx = list.indexWhere((ev) => ev == _selectedEventTemp);
          if (idx != -1) {
            oldKey = key;
            break;
          }
        }
      }
      if (oldKey != null && _selectedEventTemp != null) {
        ref.read(eventsProvider)[oldKey]!.remove(_selectedEventTemp);
      }

      // add to new dayKey
      ref.read(eventsProvider).putIfAbsent(dayKey, () => []);
      ref.read(eventsProvider)[dayKey]!.add(updatedEvent);
    });
  }

  // We'll store the event being edited so we can remove it from the old day
  Map<String, String>? _selectedEventTemp;

  @override
  Widget build(BuildContext context) {
    final selectedEvents =
        ref.watch(eventsProvider)[DateTime(
          _selectedDay!.year,
          _selectedDay!.month,
          _selectedDay!.day,
        )] ??
        []; //_getEventsForDay(_selectedDay ?? _focusedDay);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              eventLoader: _getEventsForDay,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              // fix: make "today" visible with a blue border
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: blue, width: 1),
                ),
                todayTextStyle: TextStyle(color: blue),
                // selected day is now BLUE
                selectedDecoration: BoxDecoration(
                  color: blue,
                  shape: BoxShape.circle,
                ),
                markerDecoration: const BoxDecoration(shape: BoxShape.circle),
                markersMaxCount: 3,
                markersAlignment: Alignment.bottomCenter,
                markerMargin: const EdgeInsets.only(bottom: 3),
                markerSizeScale: 0.25,
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  final dayEvents = _getEventsForDay(date);
                  final colors = <Color>[];
                  for (var event in dayEvents) {
                    final priority = event["priority"] == "true";
                    if (priority) {
                      colors.add(Colors.red);
                    } else {
                      switch (event["color"]) {
                        case "green":
                          colors.add(Colors.green);
                          break;
                        case "purple":
                          colors.add(Colors.purple);
                          break;
                        case "blue":
                          colors.add(Colors.blue);
                          break;
                        default:
                          colors.add(Colors.grey);
                      }
                    }
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        colors.take(3).map((color) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          );
                        }).toList(),
                  );
                },
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: selectedEvents.length,
                itemBuilder: (context, index) {
                  final event = selectedEvents[index];
                  final isPriority = event["priority"] == "true";
                  final color = event["color"] ?? "blue";

                  Color dotColor;
                  if (isPriority) {
                    dotColor = Colors.red;
                  } else {
                    switch (color) {
                      case "green":
                        dotColor = Colors.green;
                        break;
                      case "purple":
                        dotColor = Colors.purple;
                        break;
                      case "blue":
                        dotColor = Colors.blue;
                        break;
                      default:
                        dotColor = Colors.grey;
                    }
                  }

                  final timeRange = "${event["start"]}-${event["end"]}";
                  final title = event["name"] ?? "";
                  final note = event["note"] ?? "";
                  final phone = event["phone"] ?? "";

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.circle, size: 12, color: dotColor),
                          const SizedBox(height: 4),
                          Text(timeRange, style: TextStyle(color: dotColor)),
                        ],
                      ),
                      title: Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Phone: $phone\n$note"),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == "edit") {
                            _selectedEventTemp = event; // store old event
                            _showEditEventBottomSheet(event, index);
                          } else if (value == "delete") {
                            showCustomMacOSAlert(
                              context: context,
                              title: 'delete',
                              message: 'are you sure you want to delete event',
                              onConfirm: () {
                                setState(() {
                                  selectedEvents.removeAt(index);
                                });
                              },
                            );
                          }
                        },
                        itemBuilder:
                            (context) => const [
                              PopupMenuItem(value: "edit", child: Text("Edit")),
                              PopupMenuItem(
                                value: "delete",
                                child: Text("Delete"),
                              ),
                            ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
