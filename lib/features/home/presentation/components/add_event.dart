import 'package:admin/core/constants/colors.dart';
import 'package:admin/core/constants/constraints.dart';
import 'package:admin/core/constants/text_styles.dart';
import 'package:flutter/material.dart';

class AddEventSheet extends StatefulWidget {
  const AddEventSheet({super.key});

  @override
  State<AddEventSheet> createState() => _AddEventSheetState();
}

class _AddEventSheetState extends State<AddEventSheet> {
  final _formKey = GlobalKey<FormState>();
  final _eventNameController = TextEditingController();
  final _noteController = TextEditingController();
  final _phoneController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  bool _remindsMe = false;

  // Example categories
  final List<String> _categories = ["Brainstorm", "Design", "Workout"];

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: blue, // Blue primary color for header, selection, etc.
              onPrimary: Colors.white, // Text/icon color on primary color
              surface: Colors.white, // White background for the picker
              onSurface: Colors.black, // Text color on the background
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickStartTime() async {
    final now = TimeOfDay.now();
    final picked = await showTimePicker(
      context: context,
      initialTime: now,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: blue, // Blue as primary color (header, selection)
              onPrimary: Colors.white, // Text color on primary
              surface: Colors.white, // White background for the picker
              onSurface: Colors.black, // Text color on the background
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _startTime = picked;
      });
    }
  }

  Future<void> _pickEndTime() async {
    final now = TimeOfDay.now();
    final picked = await showTimePicker(
      context: context,
      initialTime: now,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: blue,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _endTime = picked;
      });
    }
  }

  @override
  void dispose() {
    _eventNameController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.only(
        left: defaultPadding,
        right: defaultPadding,
        top: defaultPadding,
        bottom: bottomInsets + defaultPadding,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 6,
            children: [
              Text("Add New Event", style: headline2),
              const SizedBox(height: 16),

              // Event name
              TextFormField(
                controller: _eventNameController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: blue, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  floatingLabelStyle: TextStyle(color: blue),
                  labelText: "Visitor's name*",
                  filled: true,
                  fillColor: Color(0xFFF4F4F4),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Visitor's name is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: blue, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  floatingLabelStyle: TextStyle(color: blue),
                  labelText: "Visitor's Phone*",
                  filled: true,
                  fillColor: Color(0xFFF4F4F4),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Phone is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),

              // Note
              TextFormField(
                controller: _noteController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: blue, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  floatingLabelStyle: TextStyle(color: blue),
                  labelText: "Type the note here...",
                  filled: true,
                  fillColor: Color(0xFFF4F4F4),
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 12),

              // Date
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: blue, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        floatingLabelStyle: TextStyle(color: blue),
                        labelText: "Date",
                        filled: true,
                        fillColor: const Color(0xFFF4F4F4),
                        border: const OutlineInputBorder(),
                        suffixIcon: const Icon(Icons.calendar_month),
                      ),
                      onTap: _pickDate,
                      controller: TextEditingController(
                        text:
                            _selectedDate == null
                                ? ""
                                : "${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}",
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Start Time
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: blue, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        floatingLabelStyle: TextStyle(color: blue),
                        labelText: "Start time",
                        filled: true,
                        fillColor: const Color(0xFFF4F4F4),
                        border: const OutlineInputBorder(),
                        suffixIcon: const Icon(Icons.access_time),
                      ),
                      onTap: _pickStartTime,
                      controller: TextEditingController(
                        text:
                            _startTime == null
                                ? ""
                                : _startTime!.format(context),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // End Time
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: blue, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        floatingLabelStyle: TextStyle(color: blue),
                        labelText: "End time",
                        filled: true,
                        focusColor: blue,
                        fillColor: const Color(0xFFF4F4F4),
                        border: const OutlineInputBorder(),
                        suffixIcon: const Icon(Icons.access_time),
                      ),
                      onTap: _pickEndTime,
                      controller: TextEditingController(
                        text: _endTime == null ? "" : _endTime!.format(context),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Reminds me
              Row(
                children: [
                  const Text("Priority Event", style: TextStyle(fontSize: 16)),
                  const Spacer(),
                  Switch(
                    value: _remindsMe,
                    activeColor: blue,
                    onChanged: (val) {
                      setState(() {
                        _remindsMe = val;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Create Event button
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.only(bottom: 24),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // TODO: Create the event
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    "Create Event",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
