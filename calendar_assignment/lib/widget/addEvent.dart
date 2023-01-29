import 'package:flutter/material.dart';

import '../Screens/mainscreen.dart';
import '../notification.dart';
import '../utils.dart';

class Addevent extends StatefulWidget {
  @override
  State<Addevent> createState() => _AddeventState();
}

class _AddeventState extends State<Addevent> {
  @override

  // ignore: prefer_final_fields
  late TextEditingController _eventNameController =
      TextEditingController(text: '');
  // ignore: prefer_final_fields
  late TextEditingController _startTimeController =
      TextEditingController(text: '');
  late TextEditingController _notificationController =
      TextEditingController(text: '');
  late TextEditingController _noteController = TextEditingController(text: '');
  late TextEditingController _dateController = TextEditingController(text: '');
  late TextEditingController _endTimeController =
      TextEditingController(text: '');
  TimeOfDay? start;
  TimeOfDay? notification;
  DateTime? date;
  TimeOfDay? end;
  DateTime? notificationDate;

  Widget build(BuildContext context) {
    void dispose() {
      _eventNameController.dispose();
      _startTimeController.dispose();
      _noteController.dispose();
      _notificationController.dispose();
      _dateController.dispose();
      _endTimeController.dispose();
      super.dispose;
    }

    return AlertDialog(
      title: Text("Create Event"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: "Enter Event Name",
              ),
              controller: _eventNameController,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: "Enter Note",
              ),
              controller: _noteController,
              maxLines: 4,
            ),
            GestureDetector(
              onTap: () async {
                date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );

                if (date != null) {
                  setState(() {
                    _dateController.text =
                        "${date!.year}-${date!.month}-${date!.day}";
                  });
                }
              },
              child: TextFormField(
                controller: _dateController,
                enabled: false,
                decoration: const InputDecoration(
                  hintText: "Select Event Date",
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                start = await showTimePicker(
                  context: context,
                  initialTime: const TimeOfDay(hour: 00, minute: 00),
                );

                if (start != null) {
                  setState(() {
                    _startTimeController.text =
                        "${start!.hour}:${start!.minute}";
                  });
                }
              },
              child: TextFormField(
                controller: _startTimeController,
                enabled: false,
                decoration: const InputDecoration(
                  hintText: "Select Start Time",
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (start != null) {
                  end = await showTimePicker(
                    context: context,
                    initialTime:
                        TimeOfDay(hour: start!.hour, minute: start!.minute),
                  );
                  if (end != null) {
                    setState(() {
                      _endTimeController.text = "${end!.hour}:${end!.minute}";
                    });
                  }
                } else {
                  return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Please Select Start Time"),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: (() {
                                      Navigator.canPop(context)
                                          ? Navigator.pop(context)
                                          : null;
                                    }),
                                    child: const Text(
                                      "Close",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      });
                }
              },
              child: TextFormField(
                controller: _endTimeController,
                enabled: false,
                decoration: const InputDecoration(
                  hintText: "Select End Time",
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Notify Me Before"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: () {
                              notification = TimeOfDay(hour: 00, minute: 15);
                              setState(() {
                                _notificationController.text =
                                    "Before 15 Minutes";
                              });
                              Navigator.canPop(context)
                                  ? Navigator.pop(context)
                                  : null;
                            },
                            child: Text("Before 15 Minutes"),
                          ),
                          TextButton(
                            onPressed: () {
                              notification = TimeOfDay(hour: 01, minute: 00);
                              setState(() {
                                _notificationController.text = "Before 1 Hour";
                              });
                              Navigator.canPop(context)
                                  ? Navigator.pop(context)
                                  : null;
                            },
                            child: Text("Before 1 Hour"),
                          ),
                          TextButton(
                            onPressed: () {
                              notification = TimeOfDay(hour: 24, minute: 00);
                              Navigator.canPop(context)
                                  ? Navigator.pop(context)
                                  : null;
                              setState(() {
                                _notificationController.text = "Before 1 Day";
                              });
                            },
                            child: Text("Before 1 Day"),
                          ),
                          TextButton(
                            onPressed: () async {
                              notificationDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );
                              notification = await showTimePicker(
                                context: context,
                                initialTime:
                                    const TimeOfDay(hour: 00, minute: 00),
                              );

                              if (notification != null) {
                                setState(() {
                                  _notificationController.text =
                                      "On ${notificationDate!.year}-${notificationDate!.month}-${notificationDate!.day}  ${notification!.hour}:${notification!.minute}";
                                });
                                Navigator.canPop(context)
                                    ? Navigator.pop(context)
                                    : null;
                              }
                            },
                            child: Text("Set Time"),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: (() {
                                  Navigator.canPop(context)
                                      ? Navigator.pop(context)
                                      : null;
                                }),
                                child: const Text(
                                  "Close",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              child: TextFormField(
                controller: _notificationController,
                enabled: false,
                decoration: const InputDecoration(
                  hintText: "Select Notification Time",
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: (() {
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                  }),
                  child: const Text("Close"),
                ),
                TextButton(
                  onPressed: (() {
                    if (_eventNameController != null &&
                        _noteController != null &&
                        date != null &&
                        start != null &&
                        end != null &&
                        notification != null) {
                      if (kEvents[date] != null) {
                        kEvents[date].add(
                          Event(
                            _eventNameController.text.toString(),
                            start!,
                            _notificationController.text,
                            end!,
                            _noteController.text,
                          ),
                        );
                      } else {
                        kEvents[date] = [
                          Event(
                            _eventNameController.text.toString(),
                            start!,
                            _notificationController.text,
                            end!,
                            _noteController.text,
                          ),
                        ];
                      }
                      insertEvent(
                          _eventNameController.text,
                          date!,
                          start!,
                          end!,
                          _noteController.text,
                          _notificationController.text);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainScreen(),
                        ),
                      );
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Please Fill and Select All fields"),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: (() {
                                          Navigator.canPop(context)
                                              ? Navigator.pop(context)
                                              : null;
                                        }),
                                        child: const Text(
                                          "Close",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          });
                    }
                  }),
                  child: const Text("Create Event"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
