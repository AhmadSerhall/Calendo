import 'package:admin/core/constants/colors.dart';
import 'package:admin/features/home/data/functions/events_functions.dart';
import 'package:admin/features/home/presentation/components/add_event_sheet.dart';
import 'package:admin/features/home/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int index = 0;

  List<Widget> pages = [
    const HomeScreen(),
    Container(width: 100.w, height: 100.h, color: Colors.red),
    Container(width: 100.w, height: 100.h, color: Colors.blue),
    Container(width: 100.w, height: 100.h, color: Colors.amber),
  ];

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
        return const AddEventSheet(onSave: addNewEvent, isEdit: false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: pages[index],
      // bottom bar
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: SizedBox(
          height: 60, // adjust if you want more/less height
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 0;
                  });
                },
                child: const Icon(Icons.home_outlined),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 1;
                  });
                },
                child: const Icon(Icons.access_alarm_outlined),
              ),
              const SizedBox(width: 48),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 2;
                  });
                },
                child: const Icon(Icons.notifications_none),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 3;
                  });
                },
                child: const Icon(Icons.person_outline),
              ),
            ],
          ),
        ),
      ),

      // floatingActionButton
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Transform.translate(
        offset: const Offset(0, -10), // shift FAB up a bit
        child: FloatingActionButton(
          shape: const CircleBorder(), // ensures the button is circular
          onPressed: _showAddEventBottomSheet,
          backgroundColor: blue,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
