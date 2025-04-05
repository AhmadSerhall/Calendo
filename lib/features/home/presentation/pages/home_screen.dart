import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FF),
      body: Column(
        children: [
          const SizedBox(height: 30),
          _buildCalendarSection(),
          const Divider(thickness: 1),
          Expanded(child: _buildTaskList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF8057F4),
        onPressed: () {},
        child: const Icon(Icons.add, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(Icons.calendar_today, color: Colors.grey),
              Icon(Icons.access_time, color: Colors.grey),
              SizedBox(width: 40), // for notch
              Icon(Icons.notifications_none, color: Colors.grey),
              Icon(Icons.person_outline, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarSection() {
    return TableCalendar(
      focusedDay: DateTime.now(),
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: const Color(0xFF8057F4),
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: const Color(0xFF8057F4),
          shape: BoxShape.circle,
        ),
        defaultTextStyle: const TextStyle(color: Colors.black87),
        weekendTextStyle: const TextStyle(color: Colors.black87),
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: Colors.black54),
        weekendStyle: TextStyle(color: Colors.black54),
      ),
      selectedDayPredicate: (day) => isSameDay(day, DateTime.now()),
    );
  }

  Widget _buildTaskList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        TaskCard(
          color: Colors.green,
          time: "10:00-13:00",
          title: "Design new UX flow for Michael",
          description: "Start from screen 16",
        ),
        TaskCard(
          color: Colors.purple,
          time: "14:00-15:00",
          title: "Brainstorm with the team",
          description: "Define the problem or question that...",
        ),
        TaskCard(
          color: Colors.blue,
          time: "19:00-20:00",
          title: "Workout with Ella",
          description: "We will do the legs and back workout",
        ),
      ],
    );
  }
}

class TaskCard extends StatelessWidget {
  final Color color;
  final String time;
  final String title;
  final String description;

  const TaskCard({
    super.key,
    required this.color,
    required this.time,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.circle, size: 10, color: color),
                const SizedBox(width: 6),
                Text(
                  time,
                  style: TextStyle(color: color, fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                const Icon(Icons.more_vert, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 6),
            Text(description, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
