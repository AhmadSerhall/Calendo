import 'package:admin/features/home/presentation/components/add_event.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // For the example events
  final Map<DateTime, List<Map<String, String>>> _events = {
    DateTime(2025, 4, 5): [
      {
        "time": "10:00-13:00",
        "title": "Design new UX flow for Michael",
        "description": "Start from screen 16",
        "color": "green",
      },
      {
        "time": "14:00-15:00",
        "title": "Brainstorm with the team",
        "description": "Define the problem or question that...",
        "color": "purple",
      },
      {
        "time": "19:00-20:00",
        "title": "Workout with Ella",
        "description": "We will do the legs and back workout",
        "color": "blue",
      },
    ],
  };

  List<Map<String, String>> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  // This function shows the bottom sheet
  void _showAddEventBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // so it can go full screen if needed
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return const AddEventSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedEvents = _getEventsForDay(_selectedDay ?? _focusedDay);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
            calendarStyle: CalendarStyle(
              todayDecoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              selectedDecoration: const BoxDecoration(
                color: Color(0xFF7B61FF),
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
                final List<Color> colors = [];
                final dayEvents = _getEventsForDay(date);
                for (var event in dayEvents) {
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
                final color = event["color"];
                final dotColor =
                    color == "green"
                        ? Colors.green
                        : color == "purple"
                        ? Colors.purple
                        : Colors.blue;

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
                        Text(event["time"]!, style: TextStyle(color: dotColor)),
                      ],
                    ),
                    title: Text(
                      event["title"]!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(event["description"] ?? ""),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == "edit") {
                          // Handle edit
                        } else if (value == "delete") {
                          setState(() {
                            _events[_selectedDay]!.removeAt(index);
                          });
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
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Icon(Icons.home_outlined),
            Icon(Icons.access_alarm_outlined),
            SizedBox(width: 48),
            Icon(Icons.notifications_none),
            Icon(Icons.person_outline),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEventBottomSheet,
        backgroundColor: const Color(0xFF7B61FF),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
