import 'package:flutter/material.dart';
import 'package:admin/core/constants/colors.dart';

// A single sheet for both "Add" and "Edit"
class AddEventSheet extends StatefulWidget {
  final bool isEdit; // false => "Create Event", true => "Edit Event"
  final Map<String, String>? existingEvent;
  final void Function(Map<String, String> eventData) onSave;

  const AddEventSheet({
    super.key,
    required this.onSave,
    this.isEdit = false,
    this.existingEvent,
  });

  @override
  State<AddEventSheet> createState() => _AddEventSheetState();
}

class _AddEventSheetState extends State<AddEventSheet> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _noteController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  bool _isPriority = false; // "Reminds me" or "Priority"

  @override
  void initState() {
    super.initState();
    // If we're editing, populate fields
    if (widget.isEdit && widget.existingEvent != null) {
      final e = widget.existingEvent!;
      _nameController.text = e["name"] ?? "";
      _phoneController.text = e["phone"] ?? "";
      _noteController.text = e["note"] ?? "";

      // parse date
      if (e["date"] != null) {
        final parts = e["date"]!.split("-");
        if (parts.length == 3) {
          final y = int.parse(parts[0]);
          final m = int.parse(parts[1]);
          final d = int.parse(parts[2]);
          _selectedDate = DateTime(y, m, d);
        }
      }
      // parse start time
      if (e["start"] != null) {
        _startTime = _parseTimeOfDay(e["start"]!);
      }
      // parse end time
      if (e["end"] != null) {
        _endTime = _parseTimeOfDay(e["end"]!);
      }
      // parse priority
      _isPriority = (e["priority"] == "true");
    }
  }

  TimeOfDay _parseTimeOfDay(String timeStr) {
    // "HH:mm"
    final parts = timeStr.split(":");
    final hh = int.parse(parts[0]);
    final mm = int.parse(parts[1]);
    return TimeOfDay(hour: hh, minute: mm);
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
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
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickStartTime() async {
    final now = TimeOfDay.now();
    final picked = await showTimePicker(
      context: context,
      initialTime: _startTime ?? now,
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
        _startTime = picked;
      });
    }
  }

  Future<void> _pickEndTime() async {
    final now = TimeOfDay.now();
    final picked = await showTimePicker(
      context: context,
      initialTime: _endTime ?? now,
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
    _nameController.dispose();
    _phoneController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: bottomInsets + 16,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.isEdit ? "Edit Event" : "Add New Event",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Name
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Visitor's name*",
                  filled: true,
                  fillColor: const Color(0xFFF4F4F4),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: blue, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  floatingLabelStyle: TextStyle(color: blue),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Visitor's name is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Phone
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: "Visitor's Phone*",
                  filled: true,
                  fillColor: const Color(0xFFF4F4F4),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: blue, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  floatingLabelStyle: TextStyle(color: blue),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Phone is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Note
              TextFormField(
                controller: _noteController,
                decoration: InputDecoration(
                  labelText: "Type the note here...",
                  filled: true,
                  fillColor: const Color(0xFFF4F4F4),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: blue, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  floatingLabelStyle: TextStyle(color: blue),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 12),

              // Date / Start / End
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Date",
                        filled: true,
                        fillColor: const Color(0xFFF4F4F4),
                        border: const OutlineInputBorder(),
                        suffixIcon: const Icon(Icons.calendar_month),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: blue, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        floatingLabelStyle: TextStyle(color: blue),
                      ),
                      onTap: _pickDate,
                      controller: TextEditingController(
                        text:
                            _selectedDate == null
                                ? ""
                                : "${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Date is required";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Start
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Start time",
                        filled: true,
                        fillColor: const Color(0xFFF4F4F4),
                        border: const OutlineInputBorder(),
                        suffixIcon: const Icon(Icons.access_time),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: blue, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        floatingLabelStyle: TextStyle(color: blue),
                      ),
                      onTap: _pickStartTime,
                      controller: TextEditingController(
                        text:
                            _startTime == null
                                ? ""
                                : _startTime!.format(context),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Start time is required";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),

                  // End
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "End time",
                        filled: true,
                        fillColor: const Color(0xFFF4F4F4),
                        border: const OutlineInputBorder(),
                        suffixIcon: const Icon(Icons.access_time),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: blue, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        floatingLabelStyle: TextStyle(color: blue),
                      ),
                      onTap: _pickEndTime,
                      controller: TextEditingController(
                        text: _endTime == null ? "" : _endTime!.format(context),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "End time is required";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Priority
              Row(
                children: [
                  const Text("Priority Event", style: TextStyle(fontSize: 16)),
                  const Spacer(),
                  Switch(
                    value: _isPriority,
                    activeColor: blue,
                    onChanged: (val) {
                      setState(() {
                        _isPriority = val;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Create / Edit button
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.only(bottom: 24),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Build event map
                      final newEvent = <String, String>{
                        "name": _nameController.text,
                        "phone": _phoneController.text,
                        "note": _noteController.text,
                        "priority": _isPriority ? "true" : "false",
                      };

                      // date
                      if (_selectedDate != null) {
                        newEvent["date"] =
                            "${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}";
                      }

                      // times
                      if (_startTime != null) {
                        final hour = _startTime!.hour.toString().padLeft(
                          2,
                          '0',
                        ); // e.g. "20"
                        final minute = _startTime!.minute.toString().padLeft(
                          2,
                          '0',
                        ); // e.g. "00"
                        newEvent["start"] = "$hour:$minute"; // "20:00"
                      }

                      if (_endTime != null) {
                        final hour = _endTime!.hour.toString().padLeft(2, '0');
                        final minute = _endTime!.minute.toString().padLeft(
                          2,
                          '0',
                        );
                        newEvent["end"] = "$hour:$minute";
                      }

                      // If priority => color= "red" else "blue" or user can pick
                      newEvent["color"] = _isPriority ? "red" : "blue";

                      // Done
                      widget.onSave(newEvent);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    widget.isEdit ? "Edit Event" : "Create Event",
                    style: const TextStyle(fontSize: 18, color: Colors.white),
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
