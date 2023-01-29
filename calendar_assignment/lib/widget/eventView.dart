import 'package:calendar_assignment/widget/event.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class EventView extends StatefulWidget {
  final List<Event> selectedEvents;
  final DateTime focusedDay;
  const EventView({
    required this.focusedDay,
    required this.selectedEvents,
  });

  @override
  State<EventView> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<EventView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<List<Event>>(
        valueListenable: ValueNotifier(widget.selectedEvents),
        builder: (context, value, _) {
          return ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ListTile(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return EventWidget(
                          eventName: value[index].title,
                          eventDate:
                              "${widget.focusedDay.year}-${widget.focusedDay.month}-${widget.focusedDay.day}",
                          startTime:
                              "${value[index].startTime.hour} O' Clock ${value[index].startTime.minute} minutes",
                          endTime:
                              "${value[index].endTime.hour} O' Clock ${value[index].endTime.minute} minutes",
                          note: value[index].note,
                          notification: value[index].notification,
                        );
                      },
                    );
                  },
                  title: Text('${value[index].title}'),
                  subtitle: Text('${value[index].startTime}'),
                  tileColor: Colors.blueGrey,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
